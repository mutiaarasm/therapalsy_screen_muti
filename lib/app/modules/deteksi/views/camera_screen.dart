import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'deteksi_result.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = true;
  bool _isRecording = false;
  int _currentStep = 0;
  int _remainingSeconds = 30;
  Timer? _timer;

  // Variables untuk backend integration
  List<String> _capturedFrames = [];
  Timer? _frameTimer;
  bool _isProcessing = false;
  static const String backendUrl = 'http://192.168.141.146:5000'; // Ganti dengan IP server Anda

  final List<String> instructions = [
    "Kedipkan mata dan gerakan alis anda",
    "Gerakan bibir anda dengan ",
    "Give a big smile, showing your teeth",
  ];

  final List<Color> stepColors = [
    const Color(0xFF4285F4), // Blue
    const Color(0xFFDB4437), // Red
    const Color(0xFF0F9D58), // Green
  ];

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _cameras = await availableCameras();
      if (_cameras!.isNotEmpty) {
        _controller = CameraController(
          _cameras![_isFrontCamera ? 1 : 0],
          ResolutionPreset.medium,
          enableAudio: false,
        );
        await _controller!.initialize();
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  void _toggleCamera() async {
    if (_cameras != null && _cameras!.length > 1) {
      setState(() {
        _isFrontCamera = !_isFrontCamera;
        _isCameraInitialized = false;
      });

      await _controller?.dispose();
      _controller = CameraController(
        _cameras![_isFrontCamera ? 1 : 0],
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _controller!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _currentStep = 0;
      _remainingSeconds = 30;
      _capturedFrames.clear();
    });
    _startDetectionTimer();
    _startFrameCapture();
  }

  void _startDetectionTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
        if (_remainingSeconds == 20) {
          _currentStep = 1;
        } else if (_remainingSeconds == 10) {
          _currentStep = 2;
        }
      });

      if (_remainingSeconds <= 0) {
        timer.cancel();
        _stopRecording();
      }
    });
  }

  void _startFrameCapture() {
    _frameTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_isRecording) {
        timer.cancel();
        return;
      }
      _captureFrame();
    });
  }

  Future<void> _captureFrame() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    
    try {
      final XFile image = await _controller!.takePicture();
      final Uint8List imageBytes = await image.readAsBytes();
      final String base64Image = base64Encode(imageBytes);
      
      _capturedFrames.add(base64Image);
      print('Captured frame ${_capturedFrames.length}');
    } catch (e) {
      print('Error capturing frame: $e');
    }
  }

  void _stopRecording() {
    _timer?.cancel();
    _frameTimer?.cancel();
    
    setState(() {
      _isRecording = false;
      _isProcessing = true;
    });
    
    _processDetection();
  }

  Future<void> _processDetection() async {
    if (_capturedFrames.isEmpty) {
      _showError('No frames captured');
      setState(() {
        _isProcessing = false;
      });
      return;
    }

    try {
      print('Sending ${_capturedFrames.length} frames to backend...');
      
      final response = await http.post(
        Uri.parse('$backendUrl/predict_bellspalsy'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'frames': _capturedFrames,
        }),
      ).timeout(const Duration(seconds: 60));
      
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result['success']) {
          _showDetectionResult(result);
        } else {
          _showError(result['error'] ?? 'Unknown error');
        }
      } else {
        _showError('Server error: ${response.statusCode}');
      }
    } catch (e) {
      _showError('Network error: $e');
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showDetectionResult([Map<String, dynamic>? result]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DeteksiResult(
        isPositive: result?['is_positive'] ?? false,
        confidence: result?['confidence'] ?? 0.0,
        percentage: result?['percentage'] ?? 0.0,
        prediction: result?['prediction'] ?? 'Unknown',
        confidenceLevel: result?['confidence_level'] ?? 'Unknown',
        totalFrames: result?['total_frames'] ?? 0,
        bellsPalsyFrames: result?['bellspalsy_frames'] ?? 0,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _frameTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Stack(
              children: [
                // Camera Preview
                Positioned.fill(
                  child: CameraPreview(_controller!),
                ),
                
                // Top Controls
                Positioned(
                  top: 50,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                      if (!_isRecording && !_isProcessing)
                        GestureDetector(
                          onTap: _toggleCamera,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.flip_camera_ios,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // Recording Timer and Instructions
                if (_isRecording)
                  Positioned(
                    top: 120,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        // Timer
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$_remainingSeconds seconds',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Instructions
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: stepColors[_currentStep].withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Step ${_currentStep + 1}/3',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                instructions[_currentStep],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        
                        // Progress Bar
                        const SizedBox(height: 20),
                        LinearProgressIndicator(
                          value: (30 - _remainingSeconds) / 30,
                          backgroundColor: Colors.white30,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            stepColors[_currentStep],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Start Button
                if (!_isRecording && !_isProcessing)
                  Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Position your face in the center and ensure good lighting',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _startRecording,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            'Start Bell\'s Palsy Detection',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Processing Overlay
                if (_isProcessing)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 16),
                          Text(
                            'Analyzing...',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            'Please wait while we process your video',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

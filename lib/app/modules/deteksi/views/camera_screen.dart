import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
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

  final List<String> instructions = [
    "Please blink your eyes",
    "Next, pucker your lips\nas if you're going to kiss", 
    "Give a big smile, showing your teeth",
  ];

  @override
  void initState() {
    super.initState();
    _requestPermissionAndInitCamera();
  }

  Future<void> _requestPermissionAndInitCamera() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      _cameras = await availableCameras();
      await _startCamera(CameraLensDirection.front);
    } else {
      _showPermissionDialog();
    }
  }

  void _showPermissionDialog() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Camera Permission'),
          content: const Text('Camera permission is required for detection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _startCamera(CameraLensDirection direction) async {
    try {
      final camera = _cameras?.firstWhere(
        (c) => c.lensDirection == direction,
        orElse: () => _cameras!.first,
      );
      
      if (camera != null) {
        await _controller?.dispose();
        _controller = CameraController(
          camera, 
          ResolutionPreset.high, 
          enableAudio: false
        );
        await _controller!.initialize();
        
        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Error starting camera: $e');
    }
  }

  void _flipCamera() async {
    if (_isRecording) return; // Tidak bisa ganti camera saat recording
    
    setState(() {
      _isCameraInitialized = false;
      _isFrontCamera = !_isFrontCamera;
    });
    await _startCamera(_isFrontCamera ? CameraLensDirection.front : CameraLensDirection.back);
  }

  void _toggleRecording() {
    if (_isRecording) {
      _stopRecording();
    } else {
      _startRecording();
    }
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _currentStep = 0;
      _remainingSeconds = 30;
    });
    _startDetectionTimer();
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
    });
    _showDetectionResult();
  }

  void _startDetectionTimer() {
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          
          // Ganti instruksi setiap 10 detik (30/3 = 10 detik per gerakan)
          if (_remainingSeconds == 20) {
            _currentStep = 1; // Instruksi ke-2
          } else if (_remainingSeconds == 10) {
            _currentStep = 2; // Instruksi ke-3
          }
        });
      } else {
        // Timer habis, stop recording
        timer.cancel();
        _stopRecording();
      }
    });
  }

  void _showDetectionResult() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const DeteksiResult(isPositive: true),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview (Full Screen)
            if (_isCameraInitialized && _controller != null)
              Positioned.fill(
                child: AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: CameraPreview(_controller!),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),

            // UI Overlay
            Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded, 
                          color: Colors.white
                        ),
                        onPressed: _isRecording ? null : () => Get.back(),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'DETECTION',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      // Recording indicator
                      if (_isRecording)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'REC',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        const SizedBox(width: 48),
                    ],
                  ),
                ),

                // Spacer
                const Spacer(),

                // Instructions Section (hanya muncul saat recording)
                if (_isRecording) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Text(
                          instructions[_currentStep],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.3,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Timer Display
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6, 
                            horizontal: 16
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$_remainingSeconds s',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ] else ...[
                  // Instruksi sebelum recording
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: const Text(
                      'Follow\nthe Facial Movement Instructions!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],

                // Bottom Controls
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Switch Camera Button (disabled saat recording)
                      GestureDetector(
                        onTap: _isRecording ? null : _flipCamera,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _isRecording 
                                ? Colors.white.withOpacity(0.3)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cameraswitch,
                            color: _isRecording 
                                ? Colors.white.withOpacity(0.5)
                                : Colors.white,
                            size: 32,
                          ),
                        ),
                      ),

                      const SizedBox(width: 40),

                      // Record Button (Style video record)
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, 
                              width: 4
                            ),
                          ),
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: _isRecording ? 28 : 60,
                              height: _isRecording ? 28 : 60,
                              decoration: BoxDecoration(
                                color: _isRecording ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.circular(
                                  _isRecording ? 6 : 30
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 88), // Space untuk balance
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

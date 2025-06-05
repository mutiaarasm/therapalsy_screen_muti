import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'deteksi_result.dart'; // Pastikan sudah buat file ini sesuai kebutuhan

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _controller;
  List<CameraDescription>? _cameras;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = false;
  int _currentStep = 0;

  final List<String> instructions = [
    "Follow\nthe Facial Movement Instructions!",
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
      await _startCamera(_isFrontCamera ? CameraLensDirection.front : CameraLensDirection.back);
    } else {
      if (mounted) {
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Camera Permission'),
            content: const Text('Camera permission is required to use this feature.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _startCamera(CameraLensDirection direction) async {
    final camera = _cameras?.firstWhere(
      (c) => c.lensDirection == direction,
      orElse: () => _cameras!.first,
    );
    if (camera != null) {
      await _controller?.dispose();
      _controller = CameraController(camera, ResolutionPreset.high, enableAudio: false);
      await _controller!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    }
  }

  void _flipCamera() async {
    setState(() {
      _isCameraInitialized = false;
      _isFrontCamera = !_isFrontCamera;
    });
    await _startCamera(_isFrontCamera ? CameraLensDirection.front : CameraLensDirection.back);
  }

  void _nextStep() {
    if (_currentStep < instructions.length - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      // Tampilkan hasil deteksi
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const DeteksiResult(isPositive: true), // Ganti sesuai hasil deteksi
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            if (_isCameraInitialized && _controller != null)
              Center(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_controller!),
                  ),
                ),
              )
            else
              const Center(child: CircularProgressIndicator(color: Colors.white)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onPressed: () => Get.back(),
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
                      Opacity(
                        opacity: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: null,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 36),
                  child: Text(
                    instructions[_currentStep],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.3,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _nextStep,
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.black54, size: 32),
                        ),
                      ),
                      const SizedBox(width: 32),
                      GestureDetector(
                        onTap: _flipCamera,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.cameraswitch,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
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

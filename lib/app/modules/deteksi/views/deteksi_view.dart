import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/home/views/home_view.dart';
import 'camera_screen.dart'; // Pastikan file camera_screen.dart sudah ada

class DeteksiView extends StatelessWidget {
  const DeteksiView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF316B5C);

    return Scaffold(
      backgroundColor: const Color(0xFFBDBDBD),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 8, right: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                    onPressed: () => Get.offAll(() => const HomeView())
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
            const SizedBox(height: 24),
            // Box peringatan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8686),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 38),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.lightbulb_outline, color: Colors.black87, size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Make sure you are in a bright place',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.face_6_outlined, color: Colors.black87, size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Make sure you face the camera with the correct facial position.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Icon(Icons.info_outline, color: Colors.black87, size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'The application will provide instructions for performing facial movements.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Tombol Start Detection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman kamera
                    Get.to(() => const CameraScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Start Detection',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

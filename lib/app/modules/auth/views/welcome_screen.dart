import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color(0xFFD2E7DF), // hijau tosca muda
                ],
              ),
            ),
          ),
          // Gambar proporsional, center, tidak terpotong
          Positioned(
          top: 280, // atur ke atas (semakin kecil semakin ke atas, semakin besar semakin ke bawah)
          left: 0,
          right: 0,
          child: Image.asset(
            'assets/images/welcome.png',
            fit: BoxFit.fitWidth,
            width: MediaQuery.of(context).size.width,
            ),
          ),
          // Overlay gradient agar teks & tombol tetap jelas
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.92),
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(0.38),
                ],
                stops: const [0.0, 0.4, 1.0],
              ),
            ),
          ),
          // Teks dua baris di pojok kiri atas
          Positioned(
            top: 110,
            left: 34,
            right: 24,
            child: Text(
              'Start Your Therapy\nJourney With Us!',
              style: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.w100,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ),
          // Tombol di bawah
          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Row(
              children: [
                // Sign In Button (Outline, putih, hijau)
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.toNamed('/login'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: mainGreen,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: mainGreen, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    child: const Text('Sign In'),
                  ),
                ),
                const SizedBox(width: 16),
                // Sign Up Button (Filled, hijau, putih)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed('/register'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                      elevation: 0,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

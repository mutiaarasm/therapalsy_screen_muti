import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/views/home_view.dart';

class DeteksiResult extends StatelessWidget {
  final bool isPositive; // true = positif, false = negatif

  const DeteksiResult({super.key, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bagian pink atas dengan icon centang
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainPink,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.only(top: 32, bottom: 18),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, color: mainPink, size: 48),
                    ),
                    const SizedBox(height: 18),
                    
                  ],
                ),
              ),
               //scan completed
              const SizedBox(height: 20, ),
                Text(
                'SCAN COMPLETED !',
                style: TextStyle(
                color: mainPink,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1.2,
                      ),
                    ),
              // Kalimat hasil dengan highlight positif/negatif
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFFFF7B7B),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'Detection shows,\nthat you are '),
                          TextSpan(
                            text: isPositive ? 'Positive' : 'Negative',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isPositive ? const Color(0xFFFF7B7B) : mainGreen,
                            ),
                          ),
                          const TextSpan(text: ' for Bell\'s Palsy'),
                        ],
                      ),
                    ),
              // Ways to reduce section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 132, vertical: 126),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, color: mainPink, size: 20),
                        const SizedBox(width: 7),
                        Text(
                          'Ways to reduce',
                          style: TextStyle(
                            color: mainPink,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPositive
                          ? 'Start with therapy exercises to restore facial muscle strength.'
                          : 'Stay active with facial exercises to maintain healthy facial muscle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: mainPink.withOpacity(0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              // Tombol Done
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigasi ke HomeView dan hapus semua halaman sebelumnya
                      Get.offAll(() => const HomeView());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'DONE',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

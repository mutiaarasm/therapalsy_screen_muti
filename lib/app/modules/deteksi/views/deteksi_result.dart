import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/views/home_view.dart';

class DeteksiResult extends StatelessWidget {
  final bool isPositive; // true = positif, false = negatif
  final double? percentage; // opsional: persentase hasil deteksi

  const DeteksiResult({
    super.key,
    required this.isPositive,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    // Warna hijau utama sesuai Figma/jungle green
    final Color mainGreen = const Color(0xFF306A5A);
    // Warna pink highlight untuk hasil positif
    final Color highlightPink = const Color(0xFFFF9B9B);

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
              // Bagian atas: hijau dengan icon centang
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainGreen,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                ),
                padding: const EdgeInsets.only(top: 40, bottom: 40),
                child: Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: mainGreen,
                      size: 38,
                    ),
                  ),
                ),
              ),

              // Konten bagian putih
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // Judul "SCAN COMPLETED !"
                    Text(
                      'SCAN COMPLETED !',
                      style: TextStyle(
                        color: highlightPink,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 1.0,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Hasil deteksi
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: highlightPink,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(text: 'Detection shows,\nthat you are '),
                          TextSpan(
                            text: _getResultText(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isPositive ? highlightPink : mainGreen,
                              fontSize: 16,
                            ),
                          ),
                          if (isPositive)
                            const TextSpan(text: ' for Bell\'s Palsy'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Section "Ways to reduce"
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: highlightPink,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Ways to reduce',
                                style: TextStyle(
                                  color: highlightPink,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _getAdviceText(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Tombol Done
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offAll(() => const HomeView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'DONE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method untuk menentukan text hasil
  String _getResultText() {
    if (isPositive) {
      if (percentage != null) {
        return '${percentage!.toInt()}% Positive';
      }
      return 'Positive';
    } else {
      return 'Normal';
    }
  }

  // Helper method untuk menentukan text saran
  String _getAdviceText() {
    if (isPositive) {
      return 'Start with therapy exercises to restore facial muscle strength.';
    } else {
      return 'Stay active with facial exercises to maintain healthy facial muscle.';
    }
  }
}

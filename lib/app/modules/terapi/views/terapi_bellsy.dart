import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TerapiBellsyView extends StatelessWidget {
  const TerapiBellsyView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    return Scaffold(
      backgroundColor: mainGreen,
      body: Stack(
        children: [
          // Gambar besar di atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 270,
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/terapi.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten putih scrollable
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul dan waktu
                    Text(
                      'Terapi Hari Ke-1',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: mainGreen,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: mainPink, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          '10 MENIT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainPink,
                            fontSize: 14.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'Gerakan Latihan Terapi',
                      style: TextStyle(
                        color: mainGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // List latihan
                    _TerapiLatihanCard(
                      image: 'assets/images/anak1.jpg',
                      title: 'Mouth exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 12),
                    _TerapiLatihanCard(
                      image: 'assets/images/anak2.jpg',
                      title: 'Cheeks exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 12),
                    _TerapiLatihanCard(
                      image: '',
                      title: 'Mouth exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                      isEmpty: true,
                    ),
                    const SizedBox(height: 32),
                    // Tombol Start Exercises
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow, size: 28),
                        label: const Text(
                          'START EXERCISES',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            letterSpacing: 1.1,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Tombol back selalu di atas
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card latihan: gambar bulat kiri, judul pink, subtitle abu
class _TerapiLatihanCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final Color mainPink;
  final bool isEmpty;

  const _TerapiLatihanCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.mainPink,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: mainPink, width: 1.2),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: isEmpty
                ? Container(
                    width: 44,
                    height: 44,
                    color: Colors.grey[200],
                  )
                : Image.asset(
                    image,
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: mainPink,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
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

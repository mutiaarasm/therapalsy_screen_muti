import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'mulai_terapi.dart';

class TerapiBellsyView extends StatelessWidget {
  const TerapiBellsyView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD2E7DF), Color(0xFFF7C6C6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar custom dengan tombol back yang berfungsi
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                      onPressed: () {
                        // Langsung kembali ke halaman sebelumnya
                        Get.back();
                        // Jika ingin selalu ke home, gunakan:
                        // Get.offAll(() => const HomeView());
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              // Gambar utama
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/images/terapi.png',
                    width: double.infinity,
                    height: 170,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Judul dan waktu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Terapi Hari Ke-1',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: mainGreen,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: mainPink, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          '10 MENIT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainPink,
                            fontSize: 14.5,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w400,
                        height: 1.35,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              // Section Gerakan Latihan Terapi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  'Gerakan Latihan Terapi',
                  style: TextStyle(
                    color: mainGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.5,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // List latihan
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  children: [
                    _TerapiLatihanCard(
                      image: 'assets/images/terapi.png',
                      title: 'Mouth exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 10),
                    _TerapiLatihanCard(
                      image: 'assets/images/terapi.png',
                      title: 'Cheeks exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 10),
                    _TerapiLatihanCard(
                      image: '', // Kosongkan jika belum ada gambar
                      title: 'Mouth exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                      isEmpty: true,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              // Tombol Mulai Terapi
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.offAll(() => const MulaiTerapiView());
                    },
                    icon: const Icon(Icons.play_arrow, size: 28),
                    label: const Text(
                      'MULAI TERAPI',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
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
                    letterSpacing: 0.7,
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

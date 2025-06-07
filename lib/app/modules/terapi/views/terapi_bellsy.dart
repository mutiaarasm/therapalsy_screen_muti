import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/terapi/views/mulai_terapi.dart';

class TerapiBellsyView extends StatelessWidget {
  const TerapiBellsyView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar custom persis seperti TerapiView
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                    onPressed: () => Get.back(),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'THERAPY DAY 1',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  // Agar judul tetap center
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
            // Gambar header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: mainGreen,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/images/terapi.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Expanded agar konten bisa discroll jika overflow
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Waktu & deskripsi
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
                    const SizedBox(height: 22),
                    Text(
                      'Gerakan Latihan Terapi',
                      style: TextStyle(
                        color: mainGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _TerapiLatihanCard(
                      image: 'assets/images/list1.png',
                      title: 'Mouth exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 10),
                    _TerapiLatihanCard(
                      image: 'assets/images/list2.png',
                      title: 'Cheeks exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                    ),
                    const SizedBox(height: 10),
                    _TerapiLatihanCard(
                      image: '',
                      title: 'Tongue exercises',
                      subtitle: 'lorem ipsum dolor amet hehhe',
                      mainPink: mainPink,
                      isEmpty: true,
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Get.to(() => const MulaiTerapiView());
                        },
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          ClipOval(
            child: isEmpty
                ? Container(
                    width: 44,
                    height: 44,
                    color: Colors.grey,
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
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

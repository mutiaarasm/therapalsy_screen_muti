import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../deteksi/views/deteksi_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../terapi/views/terapi_bellsy.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color greyCircle = const Color(0xFFE0E0E0);
    final Color pinkCircle = const Color(0xFFF7C6C6);

    // Progress hari ini, misal sudah sampai day 2
    final int currentDay = 2; // 1-based

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFB8CBC6), Color(0xFFF6B8C8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                  onPressed: () => Get.back(),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'PROGRESS',
                      style: TextStyle(
                        color: Colors.black,
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
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB8CBC6), Color(0xFFF6B8C8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 120),

            // Your Daily Plan Card dengan padding dan style yang rapi
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your Daily Plan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.5,
                              color: Colors.black,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'You have 1 therapy session today\nto achieve your goal.',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13.2,
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => const TerapiBellsyView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mainGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                        minimumSize: const Size(0, 36),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 7 Lingkaran Day 1-7 dengan padding horizontal 0 dan jarak antar lingkaran
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (i) {
                  final bool isDone = i < currentDay;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: isDone
                                ? mainGreen
                                : (i == currentDay
                                    ? pinkCircle.withOpacity(0.7)
                                    : greyCircle.withOpacity(0.5)),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${i + 1}',
                              style: TextStyle(
                                color: isDone ? Colors.white : Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),

            // Track Your Face Progress Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Text(
                "Track Your Face Progress",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Gallery Card 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: _ProgressGalleryCard(
                title: "Check the changes in your face since Day 1!",
                buttonText: "View Gallery",
                mainGreen: mainGreen,
              ),
            ),

            // Gallery Card 2
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
              child: _ProgressGalleryCard(
                title: "Cek Perubahan Wajah Anda\nSejak Hari Pertama!",
                buttonText: "Buka Galeri",
                mainGreen: mainGreen,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: _ProgressBottomNav(mainGreen: mainGreen),
    );
  }
}

// --- Gallery Card Widget ---
class _ProgressGalleryCard extends StatelessWidget {
  final String title;
  final String buttonText;
  final Color mainGreen;

  const _ProgressGalleryCard({
    required this.title,
    required this.buttonText,
    required this.mainGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF7C6C6), Color(0xFFF2A2A2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: 150,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: mainGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buttonText,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 7),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Bottom Navigation Bar ---
class _ProgressBottomNav extends StatelessWidget {
  final Color mainGreen;
  const _ProgressBottomNav({required this.mainGreen});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: mainGreen,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.crop_free),
          label: 'Detection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      currentIndex: 2,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAll(() => const HomeView());
            break;
          case 1:
            Get.offAll(() => const DeteksiView());
            break;
          case 2:
            Get.offAll(() => const ProgressView());
            break;
          case 3:
            Get.offAll(() => const ProfileView());
            break;
        }
      },
    );
  }
}

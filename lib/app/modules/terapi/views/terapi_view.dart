import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../deteksi/views/deteksi_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../progress/views/progress_view.dart';
import '../controllers/terapi_controller.dart';
import 'terapi_bellsy.dart';

class TerapiView extends StatelessWidget {
  const TerapiView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF316B5C);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE6C8CE), // pink soft
                  Color(0xFFF4F6F7), // putih
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
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
                            'THERAPY',
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
                const SizedBox(height: 12),
                // Card Gambar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: const Color(0xFFF2F2F2),
                      child: Image.asset(
                        'assets/images/terapi.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 260,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    'Try the therapy for 7 days, and take a picture of your face after doing the therapy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: mainGreen,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Tombol Start Exercise
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => const TerapiBellsyView());
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
                        'START EXERCISE',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _TerapiBottomNav(mainGreen: mainGreen),
    );
  }
}

// Bottom Navigation Bar sesuai gambar
class _TerapiBottomNav extends StatelessWidget {
  final Color mainGreen;
  const _TerapiBottomNav({required this.mainGreen});

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
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Get.offAll(() => const HomeView());
            break;
          case 1:
            // Navigasi ke deteksi
            Get.offAll(() => const DeteksiView());
            break;
          case 2:
            // Navigasi ke progress
            Get.offAll(() => const ProgressView());
            break;
          case 3:
          
            // Navigasi ke ProfileView
            Get.offAll(() => const ProfileView());
            break;
        }
      },
    );
  }
}


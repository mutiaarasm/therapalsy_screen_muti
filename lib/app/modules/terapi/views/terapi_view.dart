import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../deteksi/views/deteksi_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../../progress/views/progress_view.dart';
import 'terapi_bellsy.dart';

class TerapiView extends StatelessWidget {
  const TerapiView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [
          // Background hijau atas
          Container(
            height: screenHeight * 0.37, // agar hijau cukup tinggi
            width: double.infinity,
            color: mainGreen,
          ),
          // Konten utama
          SafeArea(
            child: Column(
              children: [
                // AppBar custom
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
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
                              color: Colors.white,
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
                // Spacer agar gambar turun ke bawah
                const SizedBox(height: 20),
                // Gambar dengan card putih rounded, tinggi lebih besar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                        height: 320, // Lebih panjang ke bawah
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Deskripsi
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
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
                  padding: const EdgeInsets.symmetric(horizontal: 32),
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

// Bottom Navigation Bar
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

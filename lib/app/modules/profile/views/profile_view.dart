import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile.dart';
import '../../home/views/home_view.dart';
import 'faq_screen.dart';
import 'privacy_police.dart'; // Sesuaikan path import

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  // Fungsi dialog konfirmasi logout
  void showLogoutDialog(BuildContext context, VoidCallback onLogout) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainRed = const Color(0xFFFF7B7B);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon lingkaran merah dengan tanda seru
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: mainRed, width: 3),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      '!',
                      style: TextStyle(
                        color: mainRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                // Judul
                const Text(
                  'Confirm Logout',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                // Subjudul
                const Text(
                  'Are you sure want to sign out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black45,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                ),
                const SizedBox(height: 32),
                // Tombol CANCEL dan OK
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: mainGreen, width: 2),
                          foregroundColor: mainGreen,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        child: const Text('CANCEL'),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onLogout();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 0,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF316B5C);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        // Mencegah pop dan navigasi ke halaman sebelumnya
        // Jika ingin ke HomeView:
        Get.offAll(() => const HomeView());
        // Atau bisa kosongkan jika tidak ingin melakukan apa-apa
        // dan tetap berada di halaman ini
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
            onPressed: () {
              // Langsung ke HomeView
              Get.offAll(() => const HomeView());
            },
          ),
          centerTitle: true,
          title: const Text(
            'PROFILE',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              fontSize: 20,
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFB8CBC6), // hijau muda
                Color(0xFFF6B8C8), // pink muda
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Foto profil bulat
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage('assets/images/profile.jpeg'), // Ganti dengan asset foto profil
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Nama dan email
                  const Text(
                    'Mutiara Nurzilah',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'smpolmbcantik@gmail.com',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Tombol Edit Profile
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => const EditProfileView());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'EDIT PROFILE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Menu List
                  _ProfileMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    text: 'Privacy Policy',
                    onTap: () {
                      Get.to(() => PrivacyPolicePage ());
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.help_outline,
                    text: 'FAQ',
                    onTap: () {
                      Get.to(() => FaqScreen ());
                    },
                  ),
                  _ProfileMenuItem(
                    icon: Icons.logout,
                    text: 'Sign Out',
                    onTap: () {
                      showLogoutDialog(context, () {
                        // TODO: Tambahkan logika sign out di sini, misal:
                        Get.offAllNamed('/sign-in');
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget menu list profile
class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _ProfileMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: Colors.black54, size: 26),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black38, size: 26),
            ],
          ),
        ),
      ),
    );
  }
}

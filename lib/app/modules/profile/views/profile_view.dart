import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/profile/views/edit_profile.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Latar belakang hijau atas
          Container(
            height: 250,
            width: double.infinity,
            color: mainGreen,
          ),
          // Konten utama
          SafeArea(
            child: Column(
              children: [
                // AppBar custom transparan
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'PROFILE',
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
                // Spacer agar foto profil menjorok ke bawah
                const SizedBox(height: 18),
                // Foto profil bulat dengan border putih
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6),
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/terapi.png', // Ganti sesuai asset kamu
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Nama dan email
                const Text(
                  'Mutiara Nurzilah',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'smpolmbcantik@gmail.com',
                  style: TextStyle(
                    fontSize: 14.5,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 14),
                // Tombol Edit Profile
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman edit profile
                      Get.to(() => EditProfileView());
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
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                // Menu List
                _ProfileMenuItem(
                  icon: Icons.privacy_tip_outlined,
                  text: 'Privacy Policy',
                  onTap: () {
                    // Get.to(() => PrivacyPolicyPage());
                  },
                ),
                _ProfileMenuItem(
                  icon: Icons.help_outline,
                  text: 'FAQ',
                  onTap: () {
                    // Get.to(() => FaqScreen());
                  },
                ),
                _ProfileMenuItem(
                  icon: Icons.history,
                  text: 'Sign In History',
                  onTap: () {
                    // Get.to(() => SignInHistoryPage());
                  },
                ),
                _ProfileMenuItem(
                  icon: Icons.logout,
                  text: 'Sign Out',
                  onTap: () {
                    // Tampilkan dialog logout
                  },
                ),
              ],
            ),
          ),
        ],
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/profile/views/profile_view.dart';
import '../controllers/profile_controller.dart';

class PrivacyPolicePage extends GetView<ProfileController> {
  const PrivacyPolicePage({Key? key}) : super(key: key);

  // Fungsi untuk membuat titik kecil
  Widget _dot() => Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.only(top: 6, right: 10),
        decoration: const BoxDecoration(
          color: Color(0xFF306A5A),
          shape: BoxShape.circle,
        ),
      );

  // Fungsi untuk membuat judul section
  Widget _sectionTitle(String text) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dot(),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF306A5A),
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      );

  // Fungsi untuk membuat konten section
  Widget _sectionContent(String text) => Padding(
        padding: const EdgeInsets.only(left: 26, top: 6, bottom: 22),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // Daftarkan controller jika belum ada
    if (!Get.isRegistered<ProfileController>()) {
      Get.lazyPut<ProfileController>(() => ProfileController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'PRIVACY POLICE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: ListView(
            children: [
              const SizedBox(height: 4),
              Obx(() => Center(
                    child: Text(
                      'Last Update ${controller.lastUpdate.value}',
                      style: const TextStyle(
                        color: Color(0xFFB3B3B3),
                        fontSize: 15,
                      ),
                    ),
                  )),
              const SizedBox(height: 22),
              _sectionTitle('OVERVIEW'),
              _sectionContent(
                "TheraPalsy values your privacy. This Privacy Policy explains how we collect, use, protect, and share your personal information when you use the TheraPalsy application. By accessing or using the Application, you agree to the terms set forth in this Privacy Policy.",
              ),
              _sectionTitle('Information We Collect'),
              _sectionContent(
                "Information You Provide: Information you enter directly into the App, such as Bell’s Palsy symptom data you enter, medical history, and other data related to your use of the App.\n\nAutomatically Collected Information: Information we collect automatically through your use of the App, including usage data, device data, and location data (depending on your device settings).",
              ),
              _sectionTitle('Use Of Information'),
              _sectionContent(
                "We use the information we collect for various purposes Analyzing Bell’s Palsy symptoms To provide analysis and therapy recommendations based on the symptom data you enter.",
              ),
              const SizedBox(height: 30),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigasi ke halaman edit profile
                      Get.to(() => ProfileView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF306A5A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'UNDERSTAND',
                        style: TextStyle(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}

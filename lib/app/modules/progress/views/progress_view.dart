import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/progress/controllers/progress_controller.dart';
import 'package:therapalsy_screen_muti/app/modules/progress/views/view_gallery.dart';
import 'package:therapalsy_screen_muti/app/modules/terapi/views/terapi_bellsy.dart';
import '../../deteksi/views/deteksi_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';

class ProgressView extends StatelessWidget {
  const ProgressView({super.key});

  @override
  Widget build(BuildContext context) {
    final ProgressController ctrl = Get.put(ProgressController());
    final Color mainGreen = const Color(0xFF306A5A);
    final Color greyCircle = const Color(0xFFE0E0E0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 0, right: 0),
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
      body: Obx(() => ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 22),

          // Kotak putih progress harian
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade200, width: 1.2),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Daily Task',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: Colors.black,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          '${ctrl.completedTask.value} of ${ctrl.totalTask} tasks completed.',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 13.2,
                            fontWeight: FontWeight.w400,
                            height: 1.3,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: ctrl.progressPercent,
                                  minHeight: 10,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation(mainGreen),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: mainGreen, width: 2),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.06),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '${(ctrl.progressPercent * 100).round()}%',
                                  style: TextStyle(
                                    color: mainGreen,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 26),

          // Judul bar chart
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Text(
              "Progress your face after exercise",
              style: TextStyle(
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Bar chart progress day 1-7
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 18,
                        height: (ctrl.progressDays[i] / 100) * 100, // max 100 px
                        decoration: BoxDecoration(
                          color: mainGreen,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${ctrl.progressDays[i]}%',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Day\n${i + 1}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black54,
                          height: 1.1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),

          const SizedBox(height: 22),

          // Lingkaran hari 1-7, pakai ListView horizontal agar tidak overflow
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: 66,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  final bool isActive = i + 1 == ctrl.currentDay.value;
                  final bool isDone = i + 1 < ctrl.currentDay.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: GestureDetector(
                      onTap: isActive ? () {
                        Get.to(() => TerapiBellsyView(day: i + 1));
                      } : null,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: isActive
                              ? mainGreen
                              : (isDone ? mainGreen.withOpacity(0.5) : greyCircle),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: isActive ? Colors.white : Colors.black38,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 28),

          // Judul section gallery
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

          // Gallery Card 1 (satu saja)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: mainGreen,
                borderRadius: BorderRadius.circular(18),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Check the changes in your face since Day 1!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.5,
                      fontWeight: FontWeight.w500,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 170,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => GalleryView());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: mainGreen,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "View Gallery",
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 7),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
        ],
      )),
      bottomNavigationBar: _ProgressBottomNav(mainGreen: mainGreen),
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
            Get.to(() => const HomeView());
            break;
          case 1:
            Get.to(() => const DeteksiView());
            break;
          case 2:
            Get.to(() => const ProgressView());
            break;
          case 3:
            Get.to(() => const ProfileView());
            break;
        }
      },
    );
  }
}

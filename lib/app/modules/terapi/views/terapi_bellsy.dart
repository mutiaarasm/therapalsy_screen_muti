import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/terapi/views/mulai_terapi.dart';
import 'package:therapalsy_screen_muti/app/modules/terapi/controllers/terapi_controller.dart';

class TerapiBellsyView extends StatelessWidget {
  final int day;
  const TerapiBellsyView({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final TerapiController controller = Get.put(TerapiController());
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    // Load exercises for the specific day
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExercises(day);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar custom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
                    onPressed: () => Get.back(),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'THERAPY DAY $day',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Colors.black,
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
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul gerakan
                    Text(
                      'Gerakan Latihan Terapi',
                      style: TextStyle(
                        color: mainGreen,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    // Daftar latihan menggunakan Obx
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.errorMessage.value.isNotEmpty) {
                        return Center(child: Text('Error: ${controller.errorMessage.value}'));
                      } else if (controller.exercises.isEmpty) {
                        return const Center(child: Text('Tidak ada latihan untuk hari ini'));
                      }
                      
                      return Column(
                        children: List.generate(controller.exercises.length, (index) {
                          final ex = controller.exercises[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(color: mainPink.withOpacity(0.3)),
                              ),
                              child: ListTile(
                                leading: Icon(Icons.check_circle_outline, color: mainPink, size: 34),
                                title: Text(
                                  ex.title,
                                  style: TextStyle(
                                    color: mainPink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text(
                                  ex.description,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    }),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          controller.resetExerciseIndex();
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

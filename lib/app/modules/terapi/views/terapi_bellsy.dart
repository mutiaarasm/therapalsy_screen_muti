import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Model Exercise
class Exercise {
  final String title;
  final String description;

  Exercise({
    required this.title,
    required this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
      );
}

// Fungsi fetch dari backend
Future<List<Exercise>> fetchExercises(int day) async {
  final response = await http.get(
    Uri.parse('http://192.168.100.16:5000/api/videos?day=$day'),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return (data['videos'] as List)
        .map((e) => Exercise.fromJson(e))
        .toList();
  } else {
    throw Exception('Failed to load exercises');
  }
}

// Widget utama
class TerapiBellsyView extends StatelessWidget {
  final int day;
  const TerapiBellsyView({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

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
                    // Daftar latihan dari backend
                    FutureBuilder<List<Exercise>>(
                      future: fetchExercises(day),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('Tidak ada latihan untuk hari ini'));
                        }
                        final exercises = snapshot.data!;
                        return Column(
                          children: List.generate(exercises.length, (index) {
                            final ex = exercises[index];
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
                      },
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigasi ke halaman mulai latihan
                          Get.to(() => MulaiTerapiView(day: day));
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

// Jangan lupa ganti MulaiTerapiView dengan halaman latihan video Anda!
class MulaiTerapiView extends StatelessWidget {
  final int day;
  const MulaiTerapiView({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latihan Video Day $day')),
      body: const Center(child: Text('Halaman latihan video di sini')),
    );
  }
}

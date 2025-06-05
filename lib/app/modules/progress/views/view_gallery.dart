import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/progress_controller.dart';

class ViewGallery extends GetView<ProgressController> {
  const ViewGallery({Key? key}) : super(key: key);

  // Contoh image, ganti dengan path/imagePicker jika sudah ada
  final String? day1Image =
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=facearea&w=400&h=400'; // Placeholder, ganti sesuai kebutuhan

  @override
  Widget build(BuildContext context) {
    // List judul hari
    final List<String> days = [
      'Day 1',
      'Day 2',
      'Day 3',
      'Day 4',
      'Day 5',
      'Day 6',
      'Day 7',
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'GALLERY',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 7,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 28,
                  crossAxisSpacing: 24,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(
                        days[index],
                        style: const TextStyle(
                          color: Color(0xFF2A3A3D),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFF7E7E),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: index == 0 && day1Image != null
                                ? Image.network(
                                    day1Image!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF36635D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // TODO: Implement Save Change
                },
                child: const Text(
                  'SAVE CHANGE',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

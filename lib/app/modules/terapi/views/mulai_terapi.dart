import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:therapalsy_screen_muti/app/modules/terapi/controllers/terapi_controller.dart';

class MulaiTerapiView extends StatefulWidget {
  const MulaiTerapiView({super.key});

  @override
  State<MulaiTerapiView> createState() => _MulaiTerapiViewState();
}

class _MulaiTerapiViewState extends State<MulaiTerapiView> {
  final TerapiController controller = Get.find<TerapiController>();
  YoutubePlayerController? _ytController;

  @override
  void initState() {
    super.initState();
    // Delay initialization untuk memastikan data sudah tersedia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeYoutubePlayer();
    });
    
    // Listen to exercise changes
    ever(controller.currentExerciseIndex, (_) {
      _updateYoutubePlayer();
    });
  }

  void _initializeYoutubePlayer() {
    final currentExercise = controller.currentExercise;
    print('Initializing YouTube player with exercise: ${currentExercise?.title}'); // Debug
    print('Video ID: ${currentExercise?.videoId}'); // Debug
    
    if (currentExercise != null && 
        currentExercise.videoId.isNotEmpty &&
        controller.isValidYouTubeVideoId(currentExercise.videoId)) {
      
      // Dispose existing controller
      _ytController?.dispose();
      
      _ytController = YoutubePlayerController(
        initialVideoId: currentExercise.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          controlsVisibleAtStart: true,
          enableCaption: false,
        ),
      );
      
      if (mounted) {
        setState(() {});
      }
    } else {
      print('Invalid video ID or empty exercise'); // Debug
    }
  }

  void _updateYoutubePlayer() {
    final currentExercise = controller.currentExercise;
    print('Updating YouTube player with exercise: ${currentExercise?.title}'); // Debug
    
    if (currentExercise != null && 
        currentExercise.videoId.isNotEmpty &&
        controller.isValidYouTubeVideoId(currentExercise.videoId)) {
      
      if (_ytController != null) {
        _ytController!.load(currentExercise.videoId);
      } else {
        _initializeYoutubePlayer();
      }
    }
  }

  @override
  void dispose() {
    _ytController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color mainGreen = const Color(0xFF306A5A);
    final Color mainPink = const Color(0xFFFF7B7B);

    return Scaffold(
      backgroundColor: const Color(0xFFAFAFAF),
      body: SafeArea(
        child: Obx(() {
          final currentExercise = controller.currentExercise;
          
          // Show loading state
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          // Show error state
          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.fetchExercises(controller.currentDay.value),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }
          
          // Show no exercise state
          if (currentExercise == null) {
            return const Center(
              child: Text('Tidak ada latihan tersedia'),
            );
          }

          return Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.close, size: 28, color: Colors.black54),
                    ),
                    const Spacer(),
                    Text(
                      'LATIHAN ${controller.currentExerciseIndex.value + 1} DARI ${controller.exercises.length}',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 28),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              // Video Youtube
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: _ytController != null
                      ? YoutubePlayer(
                          controller: _ytController!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: mainGreen,
                          width: double.infinity,
                          aspectRatio: 16/9, // Ubah dari 1 ke 16/9 untuk aspect ratio yang lebih baik
                        )
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.video_library_outlined, 
                                   size: 48, color: Colors.grey[400]),
                              const SizedBox(height: 8),
                              Text('Video tidak tersedia',
                                   style: TextStyle(color: Colors.grey[600])),
                              const SizedBox(height: 4),
                              Text('ID: ${currentExercise.videoId}',
                                   style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                            ],
                          ),
                        ),
                ),
              ),
              // Konten bawah
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Judul latihan
                        Text(
                          currentExercise.title,
                          style: TextStyle(
                            color: mainPink,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            letterSpacing: 1.1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        // Deskripsi
                        Text(
                          currentExercise.description,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Spacer(),
                        // Tombol berikutnya
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: controller.hasNextExercise
                                ? () {
                                    controller.nextExercise();
                                    // _updateYoutubePlayer akan dipanggil otomatis melalui ever()
                                  }
                                : () {
                                    // Jika sudah latihan terakhir, kembali ke halaman sebelumnya
                                    Get.back();
                                    Get.snackbar(
                                      'Selesai!', 
                                      'Anda telah menyelesaikan semua latihan hari ini',
                                      backgroundColor: mainGreen,
                                      colorText: Colors.white,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainGreen,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              controller.hasNextExercise ? 'BERIKUTNYA' : 'SELESAI',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Tombol sebelumnya
                        if (controller.hasPreviousExercise)
                          TextButton(
                            onPressed: () {
                              controller.previousExercise();
                              // _updateYoutubePlayer akan dipanggil otomatis melalui ever()
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black38,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: 1.1,
                              ),
                            ),
                            child: const Text('SEBELUMNYA'),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

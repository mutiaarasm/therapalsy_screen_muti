import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Model Exercise (pindahkan ke controller)
class Exercise {
  final String title;
  final String description;
  final String videoId;

  Exercise({
    required this.title,
    required this.description,
    required this.videoId,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        // Coba kedua format untuk kompatibilitas
        videoId: json['video_id'] ?? json['videoId'] ?? '',
      );
}

class TerapiController extends GetxController {
  // Observable variables
  final RxList<Exercise> exercises = <Exercise>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentDay = 1.obs;
  final RxInt currentExerciseIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Jangan load otomatis di onInit, biarkan dipanggil manual
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fetch exercises from backend
  Future<void> fetchExercises(int day) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      currentDay.value = day;
      
      print('Fetching exercises for day: $day'); // Debug log
      
      final response = await http.get(
        Uri.parse('http://192.168.141.22:5000/api/videos?day=$day'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      
      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        // Handle both response formats
        List<dynamic> videosList;
        if (data['videos'] != null) {
          videosList = data['videos'] as List;
        } else if (data is List) {
          videosList = data;
        } else {
          throw Exception('Invalid response format');
        }
        
        exercises.value = videosList
            .map((e) {
              print('Processing video: $e'); // Debug log
              return Exercise.fromJson(e);
            })
            .where((exercise) => exercise.videoId.isNotEmpty) // Filter video kosong
            .toList();
            
        print('Loaded ${exercises.length} exercises'); // Debug log
        
        // Reset index ketika load exercises baru
        resetExerciseIndex();
      } else {
        throw Exception('Failed to load exercises: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exercises: $e'); // Debug log
      errorMessage.value = 'Gagal memuat latihan: ${e.toString()}';
      exercises.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Navigation methods
  void nextExercise() {
    if (currentExerciseIndex.value < exercises.length - 1) {
      currentExerciseIndex.value++;
    }
  }

  void previousExercise() {
    if (currentExerciseIndex.value > 0) {
      currentExerciseIndex.value--;
    }
  }

  void resetExerciseIndex() {
    currentExerciseIndex.value = 0;
  }

  // Getters
  Exercise? get currentExercise {
    if (exercises.isEmpty || currentExerciseIndex.value >= exercises.length) {
      return null;
    }
    return exercises[currentExerciseIndex.value];
  }

  bool get hasNextExercise => currentExerciseIndex.value < exercises.length - 1;
  bool get hasPreviousExercise => currentExerciseIndex.value > 0;
  
  // Method untuk validasi video ID YouTube
  bool isValidYouTubeVideoId(String videoId) {
    return videoId.length == 11 && RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(videoId);
  }
}

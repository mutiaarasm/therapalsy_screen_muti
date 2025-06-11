import 'package:get/get.dart';

class ProgressController extends GetxController {
  final RxInt currentDay = 1.obs;
  final RxList<int> progressDays = List<int>.filled(7, 0).obs;
  final RxInt completedTask = 0.obs;
  final int totalTask = 7;

  // Reset ke kondisi awal (user baru)
  void resetForNewUser() {
    currentDay.value = 1;
    progressDays.value = List<int>.filled(7, 0);
    completedTask.value = 0;
  }

  // Menyelesaikan satu hari terapi
  void completeDay(int day, int percentage) {
    progressDays[day - 1] = percentage;
    completedTask.value = day;
    if (day < totalTask) {
      currentDay.value = day + 1;
    }
  }

  // Persentase progress (0.0 - 1.0)
  double get progressPercent => completedTask.value / totalTask;

  @override
  void onInit() {
    super.onInit();
    // Jika ingin reset otomatis saat controller dibuat:
    // resetForNewUser();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

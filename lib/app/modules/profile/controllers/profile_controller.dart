import 'package:get/get.dart';

class ProfileController extends GetxController {
  // Properti reaktif untuk last update
  var lastUpdate = "Not updated yet".obs;

  // Properti untuk menghitung
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi atau pengambilan data (misalnya, last update)
    lastUpdate.value = "Last update: ${DateTime.now()}"; // Contoh pengisian
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fungsi untuk meningkatkan count
  void increment() => count.value++;
}

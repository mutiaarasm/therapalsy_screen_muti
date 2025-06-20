import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var name = ''.obs;
  var confirmPassword = ''.obs;

  Future<void> registerUser() async {
    if (password.value != confirmPassword.value) {
      Get.snackbar('Error', 'Password dan konfirmasi tidak sama!',
          backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.16:5000/auth/register'), // Ganti dengan IP backend kamu
        body: {
          'username': name.value,
          'email': email.value,
          'password': password.value,
          'confirm_password': confirmPassword.value,
        },
      );

      // Karena backend Flask redirect ke halaman OTP (302) atau kembali ke register (302)
      if (response.statusCode == 302 || response.statusCode == 200) {
        // Asumsi sukses jika redirect, kamu bisa parsing response jika perlu
        Get.snackbar('Berhasil', 'Cek email untuk OTP verifikasi.',
            backgroundColor: Get.theme.primaryColor, colorText: Get.theme.colorScheme.onPrimary);
        Get.toNamed('/email-verification');
      } else {
        // Coba ambil pesan error dari response (kalau ada)
        String message = 'Registrasi gagal!';
        try {
          message = response.body;
        } catch (_) {}
        Get.snackbar('Gagal', message,
            backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghubungi server: $e');
    }
  }
}

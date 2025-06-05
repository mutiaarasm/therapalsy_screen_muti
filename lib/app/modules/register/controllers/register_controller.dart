import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        Uri.parse('http://127.0.0.1:5000/api/auth/register'), // ganti IP sesuai backend kamu
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name.value,
          'email': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Berhasil', 'Cek email untuk OTP verifikasi.',
            backgroundColor: Get.theme.primaryColor, colorText: Get.theme.colorScheme.onPrimary);
        Get.toNamed('/email-verification'); // arahkan ke halaman verifikasi OTP
      } else {
        final message = jsonDecode(response.body)['message'];
        Get.snackbar('Gagal', message, backgroundColor: Get.theme.colorScheme.error, colorText: Get.theme.colorScheme.onError);
      }
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghubungi server: $e');
    }
  }
}

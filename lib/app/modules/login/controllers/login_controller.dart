import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;

  get login => null;

  Future<void> loginUser() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/api/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email.value,
          'password': password.value,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Get.snackbar('Selamat datang', data['data']['username']);
        Get.toNamed('/home');
      } else {
        Get.snackbar('Login Gagal', jsonDecode(response.body)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Tidak dapat login: $e');
    }
  }
}

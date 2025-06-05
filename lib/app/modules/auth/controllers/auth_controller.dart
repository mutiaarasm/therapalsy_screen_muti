import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  final isLoading = false.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    clientId: '888475508285-vv1sgvf71ehn12d4evdsdaf3gbmg5ttv.apps.googleusercontent.com',
  );

  final String baseUrl = 'http://127.0.0.1:5000//auth'; // Ganti IP sesuai backend

  Future<void> register() async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );
    isLoading.value = false;

    if (response.statusCode == 201) {
      Get.snackbar('Success', 'Check email for OTP verification');
    } else {
      Get.snackbar('Error', jsonDecode(response.body)['message']);
    }
  }

  Future<void> login() async {
    isLoading.value = true;
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );
    isLoading.value = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      Get.snackbar('Welcome', data['data']['username']);
      // Simpan token kalau perlu
    } else {
      Get.snackbar('Login Failed', jsonDecode(response.body)['message']);
    }
  }

  Future<void> googleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final idToken = googleAuth.idToken;

      final response = await http.post(
        Uri.parse('$baseUrl/google'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': idToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Get.snackbar('Google Login', 'Welcome ${data['data']['username']}');
      } else {
        Get.snackbar('Google Login Failed', jsonDecode(response.body)['message']);
      }
    } catch (e) {
      Get.snackbar('Error', 'Google sign-in error: $e');
    }
  }
}

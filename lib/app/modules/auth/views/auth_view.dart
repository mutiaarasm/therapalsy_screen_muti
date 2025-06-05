import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login/Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller.usernameController,
              decoration: const InputDecoration(labelText: 'Username (register only)'),
            ),
            TextField(
              controller: controller.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.register,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: controller.isLoading.value ? null : controller.login,
              child: const Text('Login'),
            ),
            ElevatedButton.icon(
              onPressed: controller.googleLogin,
              icon: const Icon(Icons.login),
              label: const Text('Login with Google'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            ),
          ],
        )),
      ),
    );
  }
}

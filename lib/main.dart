import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:therapalsy_screen_muti/app/modules/progress/controllers/progress_controller.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
  // Inisialisasi controller saat app start
  
  Get.put(ProgressController());
  runApp(MyApp());
}

// Saat user login/register
void handleNewUser() {
  Get.find<ProgressController>().resetForNewUser();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Gunakan const dan super.key untuk best practice

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TheraPalsy',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto', // Atur font sesuai kebutuhan
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF316B5C), // Hijau sesuai desain
          secondary: const Color(0xFF316B5C),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF316B5C),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF316B5C),
            side: const BorderSide(color: Color(0xFF316B5C), width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

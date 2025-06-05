import 'package:get/get.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/splash_screen.dart';
import '../modules/auth/views/welcome_screen.dart';
import '../modules/deteksi/bindings/deteksi_binding.dart';
import '../modules/deteksi/views/deteksi_view.dart';
import '../modules/emailverification/bindings/emailverification_binding.dart';
import '../modules/emailverification/views/emailverification_view.dart';
import '../modules/forgot/bindings/forgot_binding.dart';
import '../modules/forgot/views/forgot_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/newpassword/bindings/newpassword_binding.dart';
import '../modules/newpassword/views/newpassword_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/progress/bindings/progress_binding.dart';
import '../modules/progress/views/progress_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/terapi/bindings/terapi_binding.dart';
import '../modules/terapi/views/terapi_view.dart';

// app_pages.dart

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME; // Mulai dari splash screen

  static final routes = [
    // Rute untuk SplashScreen
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),
    // Rute untuk WelcomeScreen
    GetPage(
      name: _Paths.WELCOME,
      page: () => WelcomeScreen(),
      binding: AuthBinding(),
    ),
    // Rute untuk SignInScreen
    // Rute untuk HomeScreen
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),

    // Rute untuk DeteksiScreen
    GetPage(
      name: _Paths.DETEKSI,
      page: () => const DeteksiView(),
      binding: DeteksiBinding(),
    ),
    // Rute untuk TerapyScreen
    GetPage(
      name: _Paths.TERAPI,
      page: () => const TerapiView(),
      binding: TerapiBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => const ProgressView(),
      binding: ProgressBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT,
      page: () => ForgotView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.NEWPASSWORD,
      page: () => const NewpasswordView(),
      binding: NewpasswordBinding(),
    ),
    GetPage(
      name: _Paths.EMAILVERIFICATION,
      page: () => const EmailverificationView(),
      binding: EmailverificationBinding(),
    ),
  ];
}

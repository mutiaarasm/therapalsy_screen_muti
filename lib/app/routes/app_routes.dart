part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const SPLASH = _Paths.SPLASH;
  static const WELCOME = _Paths.WELCOME;
  static const SIGN_IN = _Paths.SIGN_IN;
  static const SIGN_UP = _Paths.SIGN_UP;
  static const TERAPI = _Paths.TERAPI;
  static const DETEKSI = _Paths.DETEKSI;
  static const PROFILE = _Paths.PROFILE;
  static const PROGRESS = _Paths.PROGRESS;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD; // ✅ Tambahkan ini
  static const VERIFY_EMAIL = _Paths.VERIFY_EMAIL; // ✅ Tambahkan ini
  static const REGISTER = _Paths.REGISTER;
  static const LOGIN = _Paths.LOGIN;
  static const FORGOT = _Paths.FORGOT;
  static const OTP = _Paths.OTP;
  static const NEWPASSWORD = _Paths.NEWPASSWORD;
  static const EMAILVERIFICATION = _Paths.EMAILVERIFICATION;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const SPLASH = '/splash';
  static const WELCOME = '/welcome';
  static const SIGN_IN = '/sign-in';
  static const SIGN_UP = '/sign-up';
  static const TERAPI = '/terapi';
  static const DETEKSI = '/deteksi';
  static const PROFILE = '/profile';
  static const PROGRESS = '/progress';
  static const RESET_PASSWORD = '/reset-password';
  static const VERIFY_EMAIL = '/verify-email';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const FORGOT = '/forgot';
  static const OTP = '/otp';
  static const NEWPASSWORD = '/newpassword';
  static const EMAILVERIFICATION = '/emailverification';
}

import 'package:get/get.dart';

import '../controllers/terapi_controller.dart';

class TerapiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TerapiController>(
      () => TerapiController(),
    );
  }
}

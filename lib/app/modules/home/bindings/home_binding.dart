import 'package:get/get.dart';
import 'package:postitup/app/modules/board/controllers/board_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<BoardController>(
      () => BoardController(),
    );
  }
}

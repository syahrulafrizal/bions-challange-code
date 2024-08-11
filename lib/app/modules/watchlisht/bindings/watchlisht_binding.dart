import 'package:get/get.dart';

import '../controllers/watchlisht_controller.dart';

class WatchlishtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WatchlishtController>(
      () => WatchlishtController(),
    );
  }
}

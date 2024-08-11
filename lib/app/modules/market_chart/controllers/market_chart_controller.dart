import 'package:bionschallange/app/modules/watchlisht/controllers/watchlisht_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MarketChartController extends GetxController {
  final WatchlishtController wc = Get.find<WatchlishtController>();
  int index = Get.arguments['index'];

  @override
  void onInit() {
    super.onInit();

    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      GetPlatform.isAndroid ? DeviceOrientation.landscapeLeft : DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

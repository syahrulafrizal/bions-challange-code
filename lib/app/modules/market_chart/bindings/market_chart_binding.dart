import 'package:get/get.dart';

import '../controllers/market_chart_controller.dart';

class MarketChartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketChartController>(
      () => MarketChartController(),
    );
  }
}

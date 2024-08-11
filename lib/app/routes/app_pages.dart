import 'package:get/get.dart';

import '../modules/market_chart/bindings/market_chart_binding.dart';
import '../modules/market_chart/views/market_chart_view.dart';
import '../modules/watchlisht/bindings/watchlisht_binding.dart';
import '../modules/watchlisht/views/watchlisht_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WATCHLISHT;

  static final routes = [
    GetPage(
      name: _Paths.WATCHLISHT,
      page: () => const WatchlishtView(),
      binding: WatchlishtBinding(),
    ),
    GetPage(
      name: _Paths.MARKET_CHART,
      page: () => const MarketChartView(),
      binding: MarketChartBinding(),
    ),
  ];
}

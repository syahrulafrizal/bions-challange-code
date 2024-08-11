import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/market_chart_controller.dart';

class MarketChartView extends GetView<MarketChartController> {
  const MarketChartView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.orange,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 24,
          title: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.orange,
              child: Image.asset(
                height: 24,
                width: 24,
                controller.wc.watchlist[controller.index].icon ?? "-",
              ),
            ),
            title: Text(
              controller.wc.watchlist[controller.index].s ?? "-",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              NumberFormat("#,###.#", "en_US").format(
                controller.wc.watchlist[controller.index].dd ?? 0,
              ),
              style: TextStyle(
                fontSize: 14,
                color: (controller.wc.watchlist[controller.index].dd ?? 0) < 0 ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  NumberFormat("#,###.##", "en_US").format(
                    controller.wc.watchlist[controller.index].p ?? 0,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "${NumberFormat("#,###.##", "en_US").format(
                    controller.wc.watchlist[controller.index].dc ?? 0,
                  )}%",
                  style: TextStyle(
                    color: (controller.wc.watchlist[controller.index].dc ?? 0) < 0 ? Colors.red : Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(
            top: 16,
            left: MediaQuery.of(context).viewPadding.left + 16,
            bottom: MediaQuery.of(context).viewPadding.bottom + 16,
            right: 16,
          ),
          child: LineChart(
            LineChartData(
              minX: (controller.wc.watchlist[controller.index].chart ?? []).isEmpty
                  ? 0
                  : (controller.wc.watchlist[controller.index].chart?.first.x)!,
              minY: ((controller.wc.watchlist[controller.index].minY) ?? 0).ceilToDouble() - 5,
              maxX: (controller.wc.watchlist[controller.index].chart ?? []).isEmpty
                  ? 0
                  : (controller.wc.watchlist[controller.index].chart?.last.x)! + 1000,
              maxY: controller.wc.watchlist[controller.index].maxY!.ceilToDouble() + 5,
              lineTouchData: LineTouchData(
                getTouchedSpotIndicator: (barData, spotIndexes) {
                  return spotIndexes.map((int index) {}).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((LineBarSpot touchedSpot) {}).toList();
                  },
                  getTooltipColor: (touchedSpot) => Colors.blueGrey.withOpacity(0.7),
                  showOnTopOfTheChartBoxArea: true,
                ),
                touchSpotThreshold: 30,
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey[350],
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey[350],
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 6000,
                    getTitlesWidget: (value, meta) {
                      DateTime date = DateTime.fromMillisecondsSinceEpoch(
                        value.toInt(),
                      );
                      String text = DateFormat(
                        (date.second == 0 || value == meta.min)
                            ? "HH:mm"
                            : (date.second >= 10 && value == meta.max)
                                ? "ss"
                                : "",
                      ).format(date);

                      return Text(
                        text,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 60,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        NumberFormat("#,###", "en_US").format(value),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide.none,
                  left: BorderSide.none,
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: Colors.blue,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (p0, p1, p2, p3) {
                      return FlDotCirclePainter(
                        color: Colors.blue,
                        strokeColor: Colors.blue,
                        strokeWidth: 1,
                        radius: 4,
                      );
                    },
                    checkToShowDot: (spot, barData) {
                      if (spot == (controller.wc.watchlist[controller.index].chart?.last)) {
                        return true;
                      }
                      return false;
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.withOpacity(0.3),
                        Colors.blue.withOpacity(0.1),
                      ],
                    ),
                  ),
                  spots: controller.wc.watchlist[controller.index].chart ?? [],
                ),
              ],
            ),
            duration: const Duration(milliseconds: 500),
          ),
        ),
      ),
    );
  }
}

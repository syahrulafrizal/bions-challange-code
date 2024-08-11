import 'dart:convert';
import 'package:bionschallange/app/data/crypto.dart';
import 'package:bionschallange/app/routes/app_pages.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WatchlishtController extends GetxController {
  RxList<Crypto> watchlist = <Crypto>[].obs;
  final wsUrl = Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo');
  late WebSocketChannel channel;
  RxBool isLoaded = true.obs;

  @override
  void onInit() {
    super.onInit();

    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    watchlist.assignAll([
      Crypto(
        s: 'ETH-USD',
        icon: 'assets/ETHUSDT.png',
        p: 0,
        q: 0,
        dc: 0,
        dd: 0,
        t: 0,
      ),
      Crypto(
        s: 'BTC-USD',
        icon: 'assets/BTCUSDT.png',
        p: 0,
        q: 0,
        dc: 0,
        dd: 0,
        t: 0,
      ),
    ]);
  }

  @override
  void onReady() {
    super.onReady();
    websocket();
  }

  @override
  void onClose() {
    onUnsubscribe();
    channel.sink.close();
    super.onClose();
  }

  @override
  void dispose() {
    onUnsubscribe();
    channel.sink.close();
    super.dispose();
  }

  websocket() async {
    printInfo(info: 'ws connecting to $wsUrl');
    channel = IOWebSocketChannel.connect(wsUrl);
    await channel.ready;

    channel.stream.listen((message) {
      Crypto crypto = cryptoFromJson(message);

      int index = watchlist.indexWhere((element) => element.s == crypto.s);

      if (index != -1) {
        Crypto watchlistCrypto = watchlist[index];

        if ((watchlist[index].chart?.length ?? 0) > 300) {
          watchlist[index].chart!.removeRange(0, 120);
        }

        if ((watchlistCrypto.updatedAt == null && crypto.p != null) ||
            (crypto.updatedAt?.second != watchlistCrypto.updatedAt?.second)) {
          watchlist[index] = crypto;
          watchlist[index].icon = watchlistCrypto.icon;

          List<FlSpot> curent = watchlistCrypto.chart ?? [];

          FlSpot chartPoint = FlSpot(
            ((crypto.t ?? 0) - ((crypto.t ?? 0) % 100)).toDouble(),
            (crypto.p ?? 0).toDouble(),
          );
          watchlistCrypto.chart?.add(chartPoint);
          watchlist[index].chart = curent;

          double maxY = (watchlist[index].chart ?? [])
              .fold<double>(
                0,
                (max, e) => e.y > max ? e.y : max,
              )
              .toDouble();

          double minY = (watchlist[index].chart ?? [])
              .fold<double>(
                maxY,
                (min, e) => e.y < min ? e.y : min,
              )
              .toDouble();

          watchlist[index].maxY = maxY;
          watchlist[index].minY = minY;

          isLoaded.value = false;
        }
      }
    }, onDone: () async {
      printInfo(
        info: 'closed : ${channel.closeCode} ${channel.closeReason}',
      );
      if (channel.closeCode != null) {
        websocket();
      }
    }, onError: (error) {
      printInfo(info: 'ws error $error');
    });

    onSubscribe();
  }

  onSubscribe() async {
    channel.sink.add(
      json.encode(
        {
          "action": "subscribe",
          "symbols": watchlist.map((e) => e.s).join(","),
        },
      ),
    );
  }

  onUnsubscribe() {
    channel.sink.add(
      json.encode(
        {
          "action": "unsubscribe",
          "symbols": watchlist.map((e) => e.s).join(","),
        },
      ),
    );
  }

  onViewMarketChart(int index) async {
    await Get.toNamed(
      Routes.MARKET_CHART,
      arguments: {
        'index': index,
      },
    );

    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}

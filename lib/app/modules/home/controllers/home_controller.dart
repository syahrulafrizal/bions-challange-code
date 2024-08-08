import 'dart:convert';

import 'package:bionschallange/app/data/crypto.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  final wsUrl = Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo');
  late WebSocketChannel channel;

  RxBool isSubscribed = false.obs;

  Rxn<DateTime> datetime = Rxn<DateTime>();

  RxList<Crypto> cryptos = <Crypto>[].obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  init() async {
    channel = IOWebSocketChannel.connect(wsUrl);
    await channel.ready;

    channel.stream.listen(
      (message) {
        printInfo(info: 'message $message');
        Crypto crypto = cryptoFromJson(message);
        if (datetime.value == null && crypto.dateTime != null) {
          datetime.value = crypto.dateTime;

          cryptos.insert(0, crypto);
          cryptos.refresh();
        } else if (datetime.value != null && crypto.dateTime != null) {
          if (crypto.dateTime!.second == datetime.value!.add(const Duration(seconds: 1)).second) {
            datetime.value = crypto.dateTime;
            cryptos.insert(0, crypto);
            cryptos.refresh();
          }
        }
      },
      onDone: () async {
        printInfo(info: 'ws channel closed');
      },
      onError: (error) {
        printInfo(info: 'ws error $error');
      },
    );
  }

  onSubscribe() async {
    Map data = {
      "action": "subscribe",
      "symbols": "ETH-USD",
    };
    datetime = Rxn<DateTime>();

    isSubscribed.value = true;
    channel.sink.add(
      json.encode(
        data,
      ),
    );
  }

  onUnsubscribe() {
    isSubscribed.value = false;
    channel.sink.add(
      json.encode(
        {
          "action": "unsubscribe",
          "symbols": "ETH-USD",
        },
      ),
    );
  }
}

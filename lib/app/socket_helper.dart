import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketHelper {
  Socket socket = io('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo');
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.eodhistoricaldata.com/ws/crypto?api_token=demo'),
  );

  connectToSocket() async {
    // printInfo(info: "Connect To socket.io");

    // socket.connect();
    // socket.onConnect((_) {
    //   printInfo(info: "Socket Connected");
    // });

    socket.onConnect((_) {
      print('connect');
    });
    socket.onAny(
      (event, data) => printInfo(info: "Event : $event => $data"),
    );

    StreamBuilder(
      stream: channel.stream,
      builder: (context, snapshot) {
        return Text(snapshot.hasData ? '${snapshot.data}' : '');
      },
    );
  }

  disconnectToSocket() {
    printInfo(info: "Disconnect To socket.io");

    socket.disconnect();
    socket.onDisconnect(
      (data) => printInfo(info: "ON_DISCONNECTED : $data"),
    );
  }

  emitData(String event, dynamic data) {
    printInfo(info: "Emit Data : $event => $data");

    socket.emit(event, data);
  }

  statusSocket() {
    return socket.connected;
  }
}

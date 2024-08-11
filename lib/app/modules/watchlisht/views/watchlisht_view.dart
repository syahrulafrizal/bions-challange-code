import 'package:bionschallange/app/data/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/watchlisht_controller.dart';

class WatchlishtView extends GetView<WatchlishtController> {
  const WatchlishtView({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.orange,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('WatchlishtView'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoaded.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
            padding: const EdgeInsets.all(12),
            itemCount: controller.watchlist.length,
            itemBuilder: (_, index) {
              Crypto crypto = controller.watchlist[index];
              return ListTile(
                onTap: () => controller.onViewMarketChart(index),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      height: 32,
                      width: 32,
                      crypto.icon ?? "-",
                    ),
                  ],
                ),
                title: Text(
                  crypto.s ?? "-",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  NumberFormat("#,###.#", "en_US").format(crypto.dd ?? 0),
                  style: TextStyle(
                    fontSize: 14,
                    color: (crypto.dd ?? 0) < 0 ? Colors.red : Colors.green,
                  ),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      NumberFormat("#,###.##", "en_US").format(crypto.p ?? 0),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${NumberFormat("#,###.##", "en_US").format(crypto.dc ?? 0)}%",
                      style: TextStyle(
                        color: (crypto.dc ?? 0) < 0 ? Colors.red : Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

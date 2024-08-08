import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.onReady();
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final crypto = controller.cryptos[index];
                  return ListTile(
                    title: Text("${crypto.s} || ${crypto.p}"),
                    subtitle: Text(
                      DateFormat('yyyy-MM-dd HH:mm:ss').format(
                        crypto.dateTime ?? DateTime.now(),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: controller.cryptos.length,
              ),
            ),
            FilledButton(
              onPressed: () {
                if (controller.isSubscribed.value) {
                  controller.onUnsubscribe();
                } else {
                  controller.onSubscribe();
                }
              },
              child: Text(controller.isSubscribed.value ? 'Unsubscribe' : 'Subscribe'),
            ),
          ],
        ),
      ),
    );
  }
}

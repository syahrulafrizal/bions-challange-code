import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      title: "BIONS CHALLANGE CODE",
      initialRoute: AppPages.INITIAL,
      color: Colors.orange,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      getPages: AppPages.routes,
    ),
  );
}

import 'package:dictionaryenkh/controller/auth_controller.dart';
import 'package:dictionaryenkh/page/login.dart';
import 'package:dictionaryenkh/page/plan.dart';
import 'package:dictionaryenkh/page/signup.dart';
import 'package:dictionaryenkh/page/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();

  Get.put(AuthController());
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => Splash()),
        GetPage(name: '/login', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
        GetPage(name: '/plan', page: () => Plan()),
      ],

      home: Splash(),
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}

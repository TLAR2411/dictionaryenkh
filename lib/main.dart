import 'package:dictionaryenkh/page/login.dart';
import 'package:dictionaryenkh/page/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(DevicePreview(builder: (context) => MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => Login()),
        GetPage(name: '/signup', page: () => Signup()),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}

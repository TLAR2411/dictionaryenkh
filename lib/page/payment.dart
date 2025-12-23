import 'dart:convert';
import 'dart:io';

import 'package:dictionaryenkh/controller/auth_controller.dart';
import 'package:dictionaryenkh/page/widget/khqr_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Payment extends StatefulWidget {
  Payment({super.key});

  AuthController authController = Get.find<AuthController>();

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map planData = Get.arguments;
  Map user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    planData = planData['planData'];
    generate();
    user = widget.authController.getUserData();
  }

  bool isGenerate = false;
  String qr = "";

  Future<void> generate() async {
    try {
      final money = planData['price'].toString();
      print(money);
      // final money = 0.1;

      http.Response response = await http.get(
        Uri.parse('https://khqrapi.vercel.app/pay_qr?price=$money'),
      );

      final data = jsonDecode(response.body);

      setState(() {
        qr = data['qr'];
        isGenerate = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveQrToDevice() async {
    try {
      // Ask for permission (Android only)
      await Permission.storage.request();

      // Remove prefix if exists
      String cleanBase64 = qr.contains(',') ? qr.split(',')[1] : qr;

      // Decode base64 → bytes
      Uint8List bytes = base64Decode(cleanBase64);

      // Device directory
      final dir = await getApplicationDocumentsDirectory();
      final path =
          '${dir.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png';

      File file = File(path);
      await file.writeAsBytes(bytes);

      Get.snackbar(
        "Saved Successfully",
        "QR image saved at: $path",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Save error: $e");
      Get.snackbar(
        "Error",
        "Could not save QR image",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(""), backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            if (isGenerate == false)
              Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.black,
                ),
              ),

            if (isGenerate)
              Center(
                child: KhqrCard(
                  name: "TEANG Tela",
                  amount: planData['price'].toString(),
                  qr: qr,
                ),
              ),
            if (isGenerate)
              Container(
                padding: EdgeInsets.fromLTRB(60, 30, 60, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: saveQrToDevice,
                      child: const Text("Download QR"),
                    ),
                    ElevatedButton(
                      onPressed: saveQrToDevice,
                      child: const Text("Download QR"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

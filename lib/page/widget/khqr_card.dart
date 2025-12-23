import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class KhqrCard extends StatelessWidget {
  final String name;
  final String amount;
  final String qr;

  const KhqrCard({
    super.key,
    required this.name,
    required this.amount,
    required this.qr,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),

          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---------- Red Header ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "KHQR",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ---------- Name ----------
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 4),
              child: Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            // ---------- Amount ----------
            Text(
              "$amount",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ---------- Divider ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.black26, thickness: 1),
            ),

            const SizedBox(height: 10),

            // ---------- QR Code ----------
            QrImageView(data: qr, version: QrVersions.auto, size: 220),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

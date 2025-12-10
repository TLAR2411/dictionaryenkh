import 'package:dictionaryenkh/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({super.key});
  final AuthController authController = AuthController();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.authController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

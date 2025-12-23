import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;
  // final

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  RxString token = ''.obs;

  RxMap userData = {}.obs;

  @override
  void onInit() {
    super.onInit();

    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
    token.value = _storage.read('token') ?? '';
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  void saveToken(String tokenValue) {
    // print("SAVING TOKEN: $tokenValue");
    token.value = tokenValue;
    _storage.write('token', tokenValue);
  }

  getToken() {
    return _storage.read('token') ?? '';
  }

  getUserData() {
    return _storage.read('user') ?? {};
  }

  Future<void> getUser() async {
    final token = getToken();
    if (token.isEmpty) {
      print("TOKEN IS EMPTY — SKIPPING API CALL");
      return;
    }

    http.Response response = await http.get(
      Uri.parse(
        'https://young-scene-5d7b.g12.workers.dev/https://nubbdictapi.kode4u.tech/api/auth/me',
      ),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
    );

    if (response.statusCode == 200) {
      _storage.write('user', jsonDecode(response.body)['user']);
      // print("user: ${_storage.read('user')}");
    }
  }
}

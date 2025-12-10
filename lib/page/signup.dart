import 'dart:convert';
import 'package:dictionaryenkh/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _userNameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  bool _obscureText = true;

  Future<void> singup() async {
    final String name = _userNameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    http.Response response = await http.post(
      Uri.parse(
        'https://young-scene-5d7b.g12.workers.dev/https://nubbdictapi.kode4u.tech/api/auth/signup',
      ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    print(response.body);
    print(response.statusCode);

    Get.off(Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),

              SizedBox(height: 5),

              Text(
                "Singup to get started",
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 138, 138, 138),
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 55),

              // Username label
              const Text(
                "Username",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 1.4,
                      spreadRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    hintText: "Enter username",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password label
              const Text(
                "Email",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 1.4,
                      spreadRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _emailController,
                  // Text: true,obscure // 🔥 hide password
                  decoration: InputDecoration(
                    hintText: "Enter email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Password label
              const Text(
                "Password",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 1.4,
                      spreadRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),

                child: TextField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText; // 🔥 Toggle
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    hintText: "Enter password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 18, 62, 95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    await singup();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(fontSize: 17, color: Colors.grey),
                  ),

                  TextButton(
                    onPressed: () {
                      Get.off(Login());
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 18, 62, 95),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

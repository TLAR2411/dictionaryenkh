import 'package:dictionaryenkh/page/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),

              SizedBox(height: 5),

              Text(
                "Signin to continue",
                style: TextStyle(
                  fontSize: 18,
                  color: const Color.fromARGB(255, 138, 138, 138),
                  letterSpacing: 2,
                ),
              ),

              SizedBox(height: 45),

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
                  obscureText: true, // 🔥 hide password
                  decoration: InputDecoration(
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
                  onPressed: () {},
                  child: const Text(
                    "Sign In",
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
                      Get.off(Signup());
                    },
                    child: Text(
                      "Sign Up",
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

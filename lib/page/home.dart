import 'dart:convert';

import 'package:dictionaryenkh/controller/auth_controller.dart';
import 'package:dictionaryenkh/page/detail.dart';
import 'package:dictionaryenkh/page/plan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({super.key});
  final AuthController authController = AuthController();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController searchController = TextEditingController();
  Map userData = {};
  String? token;
  Map currentLimit = {};

  List definition = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.authController.getUser();

    userData = widget.authController.getUserData();

    token = widget.authController.getToken();

    getCurrent();

    print("userData :$userData");
  }

  Future<void> getCurrent() async {
    http.Response response = await http.get(
      Uri.parse(
        'https://young-scene-5d7b.g12.workers.dev/https://nubbdictapi.kode4u.tech/api/subscription/current',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    print(response.body);

    setState(() {
      currentLimit = jsonDecode(response.body);
    });
  }

  Future<void> search() async {
    final word = searchController.text;

    // print("word $word");
    http.Response response = await http.get(
      Uri.parse(
        'https://young-scene-5d7b.g12.workers.dev/https://nubbdictapi.kode4u.tech/api/dictionary?query=$word',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    setState(() {
      definition = jsonDecode(response.body)['words'];
    });

    // print(jsonDecode(response.body)['words']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 62, 95),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,

                    backgroundImage: AssetImage('assets/images/intro1.jpg'),
                  ),

                  SizedBox(width: 5),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData['name']}',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${userData['email']}',
                        style: TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Text(currentLimit['currentRateLimit'].toString()),
                  IconButton(
                    onPressed: () => Get.to(() => Plan()),
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 0, 141, 248), // background color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 1, //
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Distionary En-Kh",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
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
                              controller: searchController,
                              onChanged: (value) => {search()},
                              decoration: InputDecoration(
                                hintText: "Input the word to search...",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5),

                        IconButton(
                          onPressed: search,
                          icon: Icon(Icons.search),
                          color: Colors.white,
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),

                child: ListView.builder(
                  itemCount: definition.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(Detail(), arguments: definition[index]);
                        print(definition[index]);
                      },

                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.white,
                            width: 0.5, //
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  definition[index]['englishWord'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),

                                Text(
                                  "(${definition[index]['partOfSpeech'] ?? ""})",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),

                            Icon(Icons.save, color: Colors.white),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

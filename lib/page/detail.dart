import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Detail extends StatefulWidget {
  Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Map definition = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      definition = Get.arguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 62, 95),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 18, 62, 95),
        title: Text(
          "Definitions",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(10),
          // decoration: BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    definition['englishWord'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),

                  Icon(Icons.volume_up, size: 20, color: Colors.yellow),
                ],
              ),

              SizedBox(height: 4),

              Text(
                definition['englishPhonetic'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  // fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20),

              Divider(height: 1, color: Colors.white),

              SizedBox(height: 20),

              // Container(
              //   padding: EdgeInsets.all(5),
              //   decoration: BoxDecoration(
              //     color: const Color.fromARGB(255, 250, 250, 250),
              //     borderRadius: BorderRadius.all(Radius.circular(5)),
              //   ),
              //   child: Text(
              //     definition['partOfSpeech'],
              //     style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 17,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Html(data: definition['khmerDef']),
              ),

              // Html(data: definition['khmerDef']),
            ],
          ),
        ),
      ),
    );
  }
}

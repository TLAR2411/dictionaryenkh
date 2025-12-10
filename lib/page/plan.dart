import 'dart:convert';

import 'package:dictionaryenkh/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Plan extends StatefulWidget {
  Plan({super.key});

  @override
  State<Plan> createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  int selectedIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPlans();
  }

  List<dynamic> plans = [];

  Future<void> fetchPlans() async {
    final response = await http.get(
      Uri.parse(
        'https://young-scene-5d7b.g12.workers.dev/https://nubbdictapi.kode4u.tech/api/subscription/plans',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        plans = data['plans'];
      });
    } else {
      throw Exception('Failed to load plans');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Title
              Center(
                child: Text(
                  "Pricing Plan",
                  style: AppTextStyle.withColor(
                    AppTextStyle.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle
              Center(
                child: Text(
                  "Choose a subscription plan to unlock all the\nfunctionality of the application",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.withColor(
                    AppTextStyle.buttonLarge,

                    Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: plans.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          print("SELECTED PLAN: ${plans[index]}");
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _PricingCard(
                          title: plans[index]["name"],
                          subtitle: "RateLimits: ${plans[index]["rateLimit"]}"
                              .toString(),
                          price: "${plans[index]["price"]}",
                          highlight:
                              selectedIndex == index, // Example highlight
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool highlight;
  final String? badgeText;

  const _PricingCard({
    required this.title,
    required this.subtitle,
    required this.price,
    this.highlight = false,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFF6A40F2) : const Color(0xFF262626),
        borderRadius: BorderRadius.circular(16),
        border: highlight
            ? Border.all(color: Colors.white.withOpacity(0.4), width: 1.5)
            : null,
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Subtitle
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        "/mo",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),

              // Price
            ],
          ),

          // Badge
          // if (highlight && badgeText != null)
          //   Positioned(
          //     right: 0,
          //     top: 0,
          //     child: Container(
          //       padding: const EdgeInsets.symmetric(
          //         horizontal: 12,
          //         vertical: 4,
          //       ),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       child: Text(
          //         badgeText!,
          //         style: const TextStyle(
          //           color: Colors.black,
          //           fontSize: 12,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

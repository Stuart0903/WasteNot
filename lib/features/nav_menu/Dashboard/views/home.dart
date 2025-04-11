import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/controller/deposit_controller.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  final DepositController depositController = Get.put(DepositController());
  // Image paths
  static const bottle = "assets/images/homescreen_images/Bottle.png";
  static const can = "assets/images/homescreen_images/Can.png";
  static const glass = "assets/images/homescreen_images/Glass.png";
  static const coins = "assets/images/homescreen_images/coins.png";
  static const creditCard = "assets/images/homescreen_images/credit-card.png";


  @override
  Widget build(BuildContext context) {
    double containerHeight = 160;

    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Background colors
            Column(
              children: [
                Expanded(child: Container(color: Colors.green)),
                Expanded(child: Container(color: const Color(0xFFD9F9B8))),
              ],
            ),

            // Top Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Greeting\n",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [Shadow(blurRadius: 2, color: Colors.black38)],
                              ),
                            ),
                            TextSpan(
                              text: "User!!!",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                                shadows: [Shadow(blurRadius: 2, color: Colors.black38)],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Iconsax.notification, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Search bar
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Iconsax.search_normal, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Search "Payments"',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Available Points
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Available Points",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            shadows: [Shadow(blurRadius: 2, color: Colors.black45)],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "20,000",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 36, // Adjusted
                            fontWeight: FontWeight.bold,
                            shadows: [Shadow(blurRadius: 3, color: Colors.black54)],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Nepal Flag & Text
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text("🇳🇵", style: TextStyle(fontSize: 18)),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "Nepal",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [Shadow(blurRadius: 2, color: Colors.black45)],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ✅ Deposit Box (Now with the missing divider line)
            Positioned(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 2 - (containerHeight / 2),
              child: Container(
                height: containerHeight,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
                ),
                child: Column(
                  children: [
                    Text(
                      "Total Deposit",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),

                    // Deposit Items with Divider Line
                    Obx(() {
                      final quantities = depositController.itemQuantities.value;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _depositItem(bottle, "Plastic", quantities["plastic"]?.toString() ?? "0"),
                          Container(height: 50, width: 1, color: Colors.grey),
                          // ✅ Divider Line
                          _depositItem(can, "Aluminum Can", quantities["can"]?.toString() ?? "0"),
                          Container(height: 50, width: 1, color: Colors.grey),
                          // ✅ Divider Line
                          _depositItem(glass, "Glass", quantities["glass"]?.toString() ?? "0"),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Transaction Section
            Positioned(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 2 + (containerHeight / 2) + 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Transaction",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(Iconsax.arrow_right5, color: Colors.black),
                ],
              ),
            ),

            // Transaction Box
            Positioned(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 2 + (containerHeight / 2) + 56,
              child: Container(
                height: 150,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)],
                ),
                child: Column(
                  children: [
                    _transactionItem(creditCard, "Point Spending", "-200", Colors.red, Colors.blueAccent.withOpacity(0.3)),
                    Divider(color: Colors.grey, thickness: 1), // ✅ Divider Line
                    _transactionItem(coins, "Point Earned", "+3000", Colors.green, Colors.greenAccent.withOpacity(0.3)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Deposit item widget
  Widget _depositItem(String imagePath, String label, String count) {
    return Column(
      children: [
        Image.asset(imagePath, width: 40, height: 40),
        SizedBox(height: 5),
        Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black)),
        SizedBox(height: 5),
        Text(count, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  // Transaction item with colored circle
  Widget _transactionItem(String imagePath, String label, String amount, Color amountColor, Color circleColor) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: circleColor,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1)],
          ),
          child: Center(
            child: Image.asset(imagePath, width: 30, height: 30),
          ),
        ),
        SizedBox(width: 10),
        Text(label, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
        Spacer(),
        Text(amount, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: amountColor)),
        SizedBox(width: 8),
        Icon(Iconsax.arrow_right, color: Colors.black),
      ],
    );
  }
}

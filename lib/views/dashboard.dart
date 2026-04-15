import 'package:flutter/material.dart';
import '../configs/colors.dart';
import 'charger.dart';
import 'orders.dart';
import 'profile.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColor,

      appBar: AppBar(
        backgroundColor: lightColor,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/logo.png", height: 40),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Shop premium chargers",
              style: TextStyle(color: greyColor),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  card(
                    context,
                    "Chargers",
                    Icons.battery_charging_full,
                    const Charger(),
                  ),
                  card(context, "Orders", Icons.shopping_cart, const Order()),
                  card(context, "Profile", Icons.person, Profile()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget card(context, title, icon, page) {
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      child: Container(
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: primaryColor.withOpacity(0.1),
              child: Icon(icon, color: primaryColor, size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

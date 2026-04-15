import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../configs/colors.dart';
import 'dashboard.dart';
import 'orders.dart';
import 'profile.dart';
import 'charger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final screens = [
    const Dashboard(),
    const Charger(),
    const Order(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: darkColor,
        buttonBackgroundColor: primaryColor,
        height: 60,

        items: const [
          Icon(Icons.dashboard, color: lightColor),
          Icon(Icons.sports_soccer, color: lightColor),
          Icon(Icons.shopping_cart, color: lightColor),
          Icon(Icons.person, color: lightColor),
        ],

        onTap: (i) => setState(() => index = i),
      ),
    );
  }
}

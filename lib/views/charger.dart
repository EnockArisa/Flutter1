import 'package:flutter/material.dart';

class Charger extends StatelessWidget {
  const Charger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Chargers")),

      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,

        children: [
          chargerCard("Dell Big Pin", "assets/dell_big_pin.png", "Ksh 1500"),
          chargerCard(
            "Dell Small Pin",
            "assets/dell_small_pin.png",
            "Ksh 3500",
          ),
          chargerCard("Dell Type C", "assets/dell_type_c.png", "Ksh 4000"),
          chargerCard("Macbook", "assets/macbook.png", "Ksh 3800"),
        ],
      ),
    );
  }

  Widget chargerCard(String name, String image, String price) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),

      child: Column(
        children: [
          Expanded(child: Image.asset(image, fit: BoxFit.cover)),

          const SizedBox(height: 5),

          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),

          Text(
            price,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),
        ],
      ),
    );
  }
}

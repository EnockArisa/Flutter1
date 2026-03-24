import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  const Order({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Orders"), centerTitle: true),

      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Macbook"),
            subtitle: Text("Quantity: 1"),
            trailing: Text("Ksh 3500"),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Dell Big Pin"),
            subtitle: Text("Quantity: 2"),
            trailing: Text("Ksh 4500"),
          ),
        ],
      ),
    );
  }
}

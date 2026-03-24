import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile"), centerTitle: true),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: const [
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),

          SizedBox(height: 20),

          Text("User Name", style: TextStyle(fontSize: 20)),

          SizedBox(height: 10),

          Text("user@email.com", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

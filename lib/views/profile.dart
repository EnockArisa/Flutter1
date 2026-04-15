import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter1/configs/colors.dart';
import '../controllers/logincontroller.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),

      body: Center(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person, size: 100),

              const SizedBox(height: 20),

              Text(
                "User ID: ${loginController.userId.value}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(
                "Email: ${loginController.email.value}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  // logout
                  loginController.userId.value = 0;
                  loginController.email.value = "";

                  Get.offAllNamed("/login");
                },
                child: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

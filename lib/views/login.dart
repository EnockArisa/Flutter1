import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:flutter1/configs/colors.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:flutter1/controllers/logincontroller.dart';
import 'package:http/http.dart' as http;

LoginController loginController = Get.put(LoginController());

TextEditingController usernameController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future loginUser() async {
    var response = await http.post(
      Uri.parse("http://127.0.0.1/login.php"),
      body: {
        "email": usernameController.text,
        "password": passwordController.text,
      },
    );

    if (response.body == "success") {
      Get.offAndToNamed("/homescreen");
    } else {
      Get.snackbar("Login Failed", "Invalid credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrangeAccent,
      //   title: Text("Logging Page", style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      // ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "Jumia Marketplace",
            //   style: TextStyle(
            //     color: Colors.blue,
            //     fontSize: 30,
            //     fontWeight: FontWeight.w800,
            //   ),
            // ),
            Image.asset("assets/logo.png", width: 200),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter Username",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hint: Text("Email or Phone Number"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 20, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter Password",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Obx(
                () => TextField(
                  controller: passwordController,
                  obscureText: loginController
                      .passwordVisible
                      .value, // This will hide the text being entered
                  decoration: InputDecoration(
                    hint: Text("PIN or Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: GestureDetector(
                      child: Icon(
                        loginController.passwordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onTap: () {
                        loginController.togglePassword();
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            GestureDetector(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              onTap: () {
                loginUser();
              },
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 30.0, 0),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                    onTap: () {
                      Get.toNamed("/signup");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

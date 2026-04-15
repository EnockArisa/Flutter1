import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter1/configs/colors.dart';
import 'package:flutter1/controllers/signupcontroller.dart';
import 'package:http/http.dart' as http;

SignupController signupController = Get.put(SignupController());

TextEditingController firstNameController = TextEditingController();
TextEditingController secondNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  Future signupUser() async {
    var response = await http.post(
      Uri.parse("http://127.0.0.1/signup.php"),
      body: {
        "first_name": firstNameController.text,
        "second_name": secondNameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      },
    );

    if (response.body == "success") {
      Get.snackbar("Success", "Account created");
      Get.toNamed("/login");
    } else if (response.body == "exists") {
      Get.snackbar("Error", "User already exists");
    } else {
      Get.snackbar("Error", "Fill all spaces");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: EdgeInsets.all(8.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// LOGO
            Image.asset("assets/logo.png", width: 200),

            /// FIRST NAME
            label("Enter First Name"),
            inputField(firstNameController, "First Name", Icons.person),

            /// SECOND NAME
            label("Enter Second Name"),
            inputField(
              secondNameController,
              "Second Name",
              Icons.person_outline,
            ),

            /// EMAIL
            label("Enter Email"),
            inputField(emailController, "Email", Icons.email),

            /// PASSWORD
            label("Enter Password"),
            Obx(
              () => passwordField(
                passwordController,
                signupController.passwordVisible.value,
                signupController.togglePassword,
              ),
            ),

            /// CONFIRM PASSWORD
            label("Confirm Password"),
            Obx(
              () => passwordField(
                confirmPasswordController,
                signupController.confirmPasswordVisible.value,
                signupController.toggleConfirmPassword,
              ),
            ),

            SizedBox(height: 20),

            /// SIGNUP BUTTON
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
                    "Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              onTap: () {
                if (passwordController.text != confirmPasswordController.text) {
                  Get.snackbar("Error", "Passwords do not match");
                } else {
                  signupUser();
                }
              },
            ),

            /// LOGIN LINK
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 30.0, 0),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 18),
                  ),
                  GestureDetector(
                    child: Text(
                      "Login",
                      style: TextStyle(color: primaryColor, fontSize: 18),
                    ),
                    onTap: () {
                      Get.back();
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

  /// LABEL
  Widget label(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 20, 5),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  /// NORMAL INPUT FIELD
  Widget inputField(controller, hint, icon) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hint: Text(hint),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  /// PASSWORD FIELD
  Widget passwordField(controller, isVisible, toggle) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: TextField(
        controller: controller,
        obscureText: isVisible,
        decoration: InputDecoration(
          hint: Text("Password"),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: GestureDetector(
            child: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onTap: toggle,
          ),
        ),
      ),
    );
  }
}

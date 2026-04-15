import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  var userId = 0.obs;
  var email = "".obs;
  var passwordVisible = false.obs;

  Future<bool> login(user, pass) async {
    try {
      var response = await http.post(
        Uri.parse("http://127.0.0.1/login.php"),
        body: {"email": user, "password": pass},
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        userId.value = int.parse(data["user_id"].toString());
        email.value = data["email"];

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e); // helps debugging
      return false;
    }
  }

  void togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }
}

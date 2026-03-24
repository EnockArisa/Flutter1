import 'package:get/state_manager.dart';

class LoginController extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var passwordVisible = false.obs;
  login(user, pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "admin" && password.value == "123") {
      return true;
    } else {
      return false;
    }
  }

  togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }
}

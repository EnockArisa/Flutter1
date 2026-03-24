import 'package:get/state_manager.dart';

class SignupController extends GetxController {
  var firstName = "".obs;
  var secondName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmPassword = "".obs;

  var passwordVisible = false.obs;
  var confirmPasswordVisible = false.obs;

  signup(fn, sn, e, p, cp) {
    firstName.value = fn;
    secondName.value = sn;
    email.value = e;
    password.value = p;
    confirmPassword.value = cp;

    if (firstName.value.isNotEmpty &&
        secondName.value.isNotEmpty &&
        email.value.isNotEmpty &&
        password.value == confirmPassword.value) {
      return true;
    } else {
      return false;
    }
  }

  togglePassword() {
    passwordVisible.value = !passwordVisible.value;
  }

  toggleConfirmPassword() {
    confirmPasswordVisible.value = !confirmPasswordVisible.value;
  }
}

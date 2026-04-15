import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:flutter1/controllers/logincontroller.dart';
import 'package:flutter1/views/login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'configs/routes.dart';

void main() {
  Get.put(LoginController(), permanent: true);

  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter1/views/login.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'configs/routes.dart';

void main() {
  runApp(
    GetMaterialApp(
      initialRoute: "/",
      getPages: routes,
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    ),
  );
}

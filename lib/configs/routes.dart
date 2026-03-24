import 'package:flutter1/views/homescreen.dart';
import 'package:flutter1/views/login.dart';
import 'package:flutter1/views/signup.dart';
import 'package:get/get.dart';

var routes = [
  GetPage(name: "/", page: () => LoginScreen()),
  GetPage(name: "/signup", page: () => SignupScreen()),
  GetPage(name: "/homescreen", page: () => HomeScreen()),
];

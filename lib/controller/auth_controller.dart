import 'package:clean_app/screens/home_screen/home_screen.dart';
import 'package:clean_app/screens/login_screen/login_screen.dart';
// ignore: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);

    _user.bindStream(auth.userChanges());

    ever(_user, _intialScreen);
  }

  void _intialScreen(User? user) {
    if (user == null) {
      print("Login Page");
      Get.offAll<dynamic>(() => LoginScreen());
    } else {
      Get.offAll<dynamic>(() => HomeScreen());
    }
  }

  void register(String email,String password) {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "ASD",
            style: TextStyle(color: Colors.amber),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.amber),
          ));
    }
  }

  void login(String email,String password) {
    try {
      auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("About User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "ASD",
            style: TextStyle(color: Colors.amber),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.amber),
          ));
    }
  }
}

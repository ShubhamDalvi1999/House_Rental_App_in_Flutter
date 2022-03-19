import 'package:flutter/material.dart';
import 'SignUpandLoginpages/LoginPage.dart';
import 'SignUpandLoginpages/RegisterPage.dart';

class ToggleScreen extends StatefulWidget {
  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  bool isToogle = false;

  void toggleScreen() {
    setState(() {
      isToogle = !isToogle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToogle) {
      return RegisterPage(
        toggleScreen: toggleScreen,
      );
    } else {
      print("in login page");
      return LoginPage(
        toggleScreen: toggleScreen,
      );
    }
  }
}

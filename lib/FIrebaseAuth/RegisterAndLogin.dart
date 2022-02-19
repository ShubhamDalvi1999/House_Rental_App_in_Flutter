import 'package:database_curd_demo_app/SignUpandLoginpages/RegisterPage.dart';
import 'package:flutter/material.dart';

import '../SignUpandLoginpages/LoginPage.dart';

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

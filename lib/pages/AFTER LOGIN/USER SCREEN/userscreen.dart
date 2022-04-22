import 'package:flutter/material.dart';

class UserLandingPage extends StatefulWidget {
  UserLandingPage({Key? key}) : super(key: key);

  @override
  State<UserLandingPage> createState() => _UserLandingPageState();
}

class _UserLandingPageState extends State<UserLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(" Normal user will see this"),
    );
  }
}

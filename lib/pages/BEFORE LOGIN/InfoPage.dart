import 'package:flutter/material.dart';

class RealEstate extends StatefulWidget {
  RealEstate({Key? key}) : super(key: key);

  @override
  State<RealEstate> createState() => _RealEstateState();
}

class _RealEstateState extends State<RealEstate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Building 1 and 2"),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:database_curd_demo_app/FireStoreDatabase/MonthlyData.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserdata {
  String? name;
  String? age;
  String? rentgiven;
  bool? monthlyrent;
  int? partialrentgiven;
  int? contactnumber;
  int? rating;

  FirebaseUserdata({
    required this.name,
    required this.age,
    required this.rentgiven,
    required this.monthlyrent,
    required this.contactnumber,
    required this.rating,
    required this.partialrentgiven,
  });

  Map<String, dynamic> addUsertoMap() {
    return {
      "name": name,
      "age": age,
      "monthlyrent": monthlyrent,
      "rentgiven": rentgiven,
      "contactnumber": contactnumber,
      "rating": rating,
      "partialrentgiven": partialrentgiven,
    };
  }

  void addUser(name, age, monthlyrent, rentgiven, contactnumber, rating,
      partialrentgiven, monthdate) {
    FirebaseUserdata UserToAdd = FirebaseUserdata(
      name: this.name,
      age: this.age,
      monthlyrent: this.monthlyrent,
      rentgiven: this.rentgiven,
      contactnumber: this.contactnumber,
      rating: this.rating,
      partialrentgiven: this.partialrentgiven,
    );
    FirebaseFirestore.instance
        .collection("Userdata")
        .doc("$name")
        .collection("$name 's personal data")
        .add(UserToAdd.addUsertoMap());
  }

  void addUsersMontlyData() {
    MonthlyData monthlyData = MonthlyData(
        month: DateTime.now().month,
        fullrentgivenondate: DateTime.now().day,
        partialrentgivenondate: DateTime.now().day,
        rentgivenby: "Shubham",
        paymentmethod: "CashPayment");
    FirebaseFirestore.instance
        .collection("Userdata")
        .doc("$name")
        .collection("monthly $name data")
        .add(monthlyData.toMap());
  }
}

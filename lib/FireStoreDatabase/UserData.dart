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

  //converting data into map so we can upload it in firestore
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

  //adding only user personal data
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

  //adding corresponding users monthly data for a year
  //Todo: adding condition for only one entry per month
  void addUsersMontlyData() async {
    //firestore instance to query data , to apply conditions to add data to database
    /*var dbRef ;
     await FirebaseFirestore.instance
        .collection("Userdata")
        .doc("$name")
        .collection("monthly $name data")
        .where("month", isEqualTo: DateTime.now().month)
        .get()*/
    var dbRef;
    await FirebaseFirestore.instance
        .collection("Userdata")
        .doc("$name")
        .collection("monthly $name data")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        for (var iter in value.docs) {
          if (iter["month"] == DateTime.now().month) {
            print("user entering duplicate entry of month");
          } else {
            print(
                "user entering this months detail for first time allowing it");
          }
        }
      }
    });

    MonthlyData monthlyData = MonthlyData(
        month: DateTime.november,
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

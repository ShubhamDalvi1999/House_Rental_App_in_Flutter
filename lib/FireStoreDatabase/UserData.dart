import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('notes');

class FirebaseUserdata {
  String? name;
  String? age;
  String? rentgiven;
  bool? monthlyrent;
  int? contactnumber;
  int? rating;

  FirebaseUserdata({
    required this.name,
    required this.age,
    required this.rentgiven,
    required this.monthlyrent,
    required this.contactnumber,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "monthlyrent": monthlyrent,
      "rentgiven": rentgiven,
      "contactnumber": contactnumber,
      "rating": rating,
    };
  }

  void addUser(name, age, monthlyrent, rentgiven, contactnumber, rating) {
    FirebaseUserdata UserToAdd = FirebaseUserdata(
      name: this.name,
      age: this.age,
      monthlyrent: this.monthlyrent,
      rentgiven: this.rentgiven,
      contactnumber: this.contactnumber,
      rating: this.rating,
    );
    FirebaseFirestore.instance.collection("Userdata").add(UserToAdd.toMap());
  }
}

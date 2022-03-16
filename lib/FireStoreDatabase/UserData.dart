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
  DateTime? fullrentgivenondate;
  DateTime? partialrentgivenondate;
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
    required this.fullrentgivenondate,
    required this.partialrentgivenondate,
    required this.partialrentgiven,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "monthlyrent": monthlyrent,
      "rentgiven": rentgiven,
      "contactnumber": contactnumber,
      "rating": rating,
      "fullrentgivenondate": fullrentgivenondate,
      "partialrentgivenondate": partialrentgivenondate,
      "partialrentgiven": partialrentgiven,
    };
  }

  void addUser(name, age, monthlyrent, rentgiven, contactnumber, rating,
      fullrentgivenondate, partialrentgivenondate, partialrentgiven) {
    FirebaseUserdata UserToAdd = FirebaseUserdata(
      name: this.name,
      age: this.age,
      monthlyrent: this.monthlyrent,
      rentgiven: this.rentgiven,
      contactnumber: this.contactnumber,
      rating: this.rating,
      fullrentgivenondate: this.fullrentgivenondate,
      partialrentgivenondate: this.partialrentgivenondate,
      partialrentgiven: this.partialrentgiven,
    );
    FirebaseFirestore.instance.collection("Userdata").add(UserToAdd.toMap());
  }
}

import 'package:flutter/material.dart';

import '../dbhelper.dart';

class Insertdata extends StatefulWidget {
  const Insertdata({Key? key}) : super(key: key);

  @override
  State<Insertdata> createState() => _InsertdataState();
}

class _InsertdataState extends State<Insertdata> {
  final personName = TextEditingController();
  final age = TextEditingController();
  final monthlyrent = TextEditingController();
  int rentgiven = 100;
  int rentradiogroup = 10;

  final dbhelper = DatabaseHelper.instance;

  //insterting input from user as a row in database
  void insertdata() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: personName.text,
      DatabaseHelper.columnAge: age.text,
      DatabaseHelper.columnMonthlyRent: monthlyrent.text,
      DatabaseHelper.columnRentGiven: rentgiven,
    };
    final id = await dbhelper.insert(row);
    print("inserted 1 row with id:" + id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.green,
        title: const Text("Insert some data into table"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: personName,
            decoration: const InputDecoration(
              hintText: 'enter a rented persons name',
              labelText: 'Person name ',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: age,
            decoration: const InputDecoration(
              hintText: 'enter ur age',
              labelText: 'Age',
              prefixIcon: Icon(Icons.graphic_eq_rounded),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: monthlyrent,
            decoration: const InputDecoration(
              hintText: 'enter his monthly rent',
              labelText: 'Monthly rent',
              prefixIcon: Icon(Icons.monetization_on_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Radio(
                      value: 1,
                      groupValue: rentradiogroup,
                      onChanged: (val) {
                        rentradiogroup = 1;
                        rentgiven = 1;
                        setState(() {});
                      }),
                  const Text("True"),
                ],
              ),
              Row(
                children: [
                  Radio(
                      value: 0,
                      groupValue: rentradiogroup,
                      onChanged: (val) {
                        rentradiogroup = 0;
                        rentgiven = 0;
                        setState(() {});
                      }),
                  const Text("False"),
                ],
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {
              insertdata();
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.purple,
              onSurface: Colors.grey,
              side: const BorderSide(color: Colors.black, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 20,
            ),
            child: const Text("Add data to database"),
          ),
        ],
      ),
    );
  }
}

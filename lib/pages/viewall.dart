import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../dbhelper.dart';

class ViewAllRentals extends StatefulWidget {
  ViewAllRentals({Key? key}) : super(key: key);

  @override
  _ViewAllRentalsState createState() => _ViewAllRentalsState();
}

class _ViewAllRentalsState extends State<ViewAllRentals> {
  final dbhelper = DatabaseHelper.instance;
  var allrows;
  List<Map<String, dynamic>> listmap = [];
  // = [
  //   {"default": 0},
  //   {"null": 90},
  //   {"bs": 58}
  // ];

  //function to return all rows in the form of List of mapof(String,dynamic)
  Future<List<Map<String, dynamic>>?> viewall() async {
    var allrows = await dbhelper.queryall();
    for (var element in allrows!) {
      print(element);
    }
    // print('length is $length');
    listmap = allrows;
    return allrows;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("View all"),
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    viewall();
                  });
                },
                child: const Text(" I want to see all data")),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listmap.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // onTap: () {
                    //   viewall();
                    //   setState(() {});
                    // },
                    leading: const Icon(Icons.person),
                    title: Text(listmap[index].values.elementAt(1).toString()),
                    subtitle: Text(
                        'Monthly Rent: ${listmap[index].values.elementAt(3).toString()}'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

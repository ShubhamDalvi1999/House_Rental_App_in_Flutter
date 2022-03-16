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
  static int total_remaining_rent = 0;
  static var check;
  List<Map<String, dynamic>> listmap = [];

  //function to return all rows in the form of List of mapof(String,dynamic)
  Future<List<Map<String, dynamic>>?> viewall() async {
    var allrows = await dbhelper.queryall();
    for (var element in allrows!) {
      print(element);
    }
    total_remaining_rent = 0;
    listmap = allrows;
    for (var item in listmap) {
      if (item.values.elementAt(4) == 1) {
        continue;
      } else {
        total_remaining_rent += int.parse(item.values.elementAt(3).toString());
      }
    }
    return allrows;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() {
                viewall();
              });
            },
            child: const Text(" View all the data")),
        Container(
          width: _mediaQuery.width * 0.89,
          height: _mediaQuery.height * 0.6,
          child: Expanded(
            //scrolling works with only expanded ,not with singlescrollview or container inside ssview
            child: Scrollbar(
              //isAlwaysShown: true, //gives error
              //               "The Scrollbar requires a single ScrollPosition in order to be painted.
              // When Scrollbar.isAlwaysShown is true, the associated Scrollable widgets must have unique ScrollControllers."
              showTrackOnHover: true,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listmap.length,
                  itemBuilder: (context, index) {
                    //logic to dynamically generate the status of rent given
                    if (listmap[index].values.elementAt(4) == 1) {
                      check = 'Yes';
                    } else {
                      check = 'No';
                    }

                    return ListTile(
                      leading: const Icon(Icons.person),
                      title:
                          Text(listmap[index].values.elementAt(1).toString()),
                      subtitle: Text(
                          '''Monthly Rent: ${listmap[index].values.elementAt(3).toString()}   Rent Given  :  $check '''),
                    );
                  }),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            "Total Remaining Rent: $total_remaining_rent INR",
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../dbhelper.dart';

class DeleteData extends StatefulWidget {
  DeleteData({Key? key}) : super(key: key);

  @override
  _DeleteDataState createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  var deletecontroller = TextEditingController();
  final dbhelper = DatabaseHelper.instance;

  void delete() async {
    var id = await dbhelper.deletedata(int.parse(deletecontroller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        backgroundColor: Colors.green,
        title: const Text("Delete"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: deletecontroller,
          decoration: const InputDecoration(
            hintText: 'Insert the id which us want to delete from the table',
            labelText: 'Delete using id ',
            prefixIcon: Icon(Icons.delete_outline),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(),
        ElevatedButton(
          onPressed: () {
            delete();
          },
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.purple,
            onSurface: Colors.grey,
            side: const BorderSide(color: Colors.black, width: 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 20,
          ),
          child: const Text("DELETE from database"),
        ),
      ]),
    );
  }
}

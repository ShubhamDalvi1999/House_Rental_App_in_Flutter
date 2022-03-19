import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/dbhelper.dart';

class DeleteData extends StatefulWidget {
  DeleteData({Key? key}) : super(key: key);

  @override
  _DeleteDataState createState() => _DeleteDataState();
}

class _DeleteDataState extends State<DeleteData> {
  var deletecontroller = TextEditingController();
  final dbhelper = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>(); //Formkey to validate entered values
  void delete() async {
    var id = await dbhelper.deletedata(int.parse(deletecontroller.text));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            controller: deletecontroller,
            validator: (value) {
              //VALIDATION
              if (value!.isEmpty) {
                return "ID cannot be empty";
              }
            },
            decoration: const InputDecoration(
              hintText: 'Insert the id which us want to delete from the table',
              labelText: 'Delete using id ',
              prefixIcon: Icon(Icons.delete_outline),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                delete();
              }
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Color.fromARGB(255, 197, 77, 11),
              onSurface: Colors.grey,
              side: const BorderSide(
                  color: Color.fromARGB(255, 255, 255, 255), width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 20,
            ),
            child: const Text("DELETE from database"),
          ),
        ]),
      ),
    );
  }
}

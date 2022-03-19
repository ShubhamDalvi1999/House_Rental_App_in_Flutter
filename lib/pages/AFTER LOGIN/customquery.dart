import 'package:flutter/material.dart';

import '../../models/dbhelper.dart';

class CustomQuery extends StatefulWidget {
  CustomQuery({Key? key}) : super(key: key);

  @override
  _CustomQueryState createState() => _CustomQueryState();
}

class _CustomQueryState extends State<CustomQuery> {
  final dbhelper = DatabaseHelper.instance;
  final age = TextEditingController();
  final rentGiven = TextEditingController();
  List<Map<String, dynamic>> listmap = [];
  final _formKey = GlobalKey<FormState>(); //Formkey to validate entered values

  Future<List<Map<String, dynamic>>> customquery() async {
    listmap = (await dbhelper.queryspecific(age.text, rentGiven.text))!;
    return listmap;
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: age,
              validator: (value) {
                if (value == null) {
                  return "Age cannot be blank";
                } else if (int.tryParse(value) != null) {
                  //if stirng is only number
                  if (int.parse(value) <= 0) {
                    return "value cannot be 0 or negative";
                  }
                } else if (int.tryParse(value) == null) {
                  return "enter a number";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'enter which age customers do u want to see',
                labelText: 'Age',
                prefixIcon: Icon(Icons.graphic_eq_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: rentGiven,
              validator: (value) {
                if (value == null) {
                  return "Cannot be blank";
                } else if (int.tryParse(value) != null) {
                  if (int.parse(value) > 1) {
                    return "It cannot be other than 0 or 1";
                  } else if (int.parse(value) < 0) {
                    return "It cannot be other than 0 or 1";
                  }
                } else if (int.tryParse(value) == null) {
                  return "enter a number only";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText:
                    'Enter 0 if u want to see customers who have given rent else enter 1',
                labelText: 'Monthly rent given or not (0/1)',
                prefixIcon: Icon(Icons.monetization_on_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: _mediaQuery.width * 0.89,
              height: _mediaQuery.height * 0.4,
              child: Expanded(
                child: Scrollbar(
                  showTrackOnHover: true,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listmap.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                              listmap[index].values.elementAt(2).toString()),
                          subtitle: Text(
                              'Monthly Rent: ${listmap[index].values.elementAt(3).toString()}'),
                        );
                      }),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    customquery();
                  });
                }
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
              child: const Text("Show results"),
            ),
          ],
        ),
      ),
    );
  }
}

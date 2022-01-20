import 'package:flutter/material.dart';

import '../dbhelper.dart';

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

  Future<List<Map<String, dynamic>>?> customquery() async {
    var allrows = await dbhelper.queryspecific(age.text, rentGiven.text);
    listmap = allrows!;
    return allrows;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: Colors.green,
          title: const Text("Filter data from table"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: age,
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
            TextField(
              controller: rentGiven,
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
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: listmap.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(listmap[index].values.elementAt(2).toString()),
                    subtitle: Text(
                        'Monthly Rent: ${listmap[index].values.elementAt(3).toString()}'),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  customquery();
                });
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

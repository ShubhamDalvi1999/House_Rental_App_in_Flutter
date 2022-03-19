import 'package:database_curd_demo_app/FireStoreDatabase/MonthlyData.dart';
import 'package:database_curd_demo_app/models/index.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import '../../../FireStoreDatabase/UserData.dart';
import '../../../models/dbhelper.dart';

class Insertdata extends StatefulWidget {
  const Insertdata({Key? key}) : super(key: key);

  @override
  State<Insertdata> createState() => _InsertdataState();
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return time == null ? null : DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class _InsertdataState extends State<Insertdata> {
  final personName = TextEditingController();
  final age = TextEditingController();
  final monthlyrent = TextEditingController();
  final contactno = TextEditingController();
  final trust = TextEditingController();
  final fullrentgivenondate = TextEditingController();
  final partialrentgiven = TextEditingController();
  final partialrentgivenondate = TextEditingController();
  int rentgiven = 100;
  int rentradiogroup = 10;
  final _formKey = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd HH:mm");
  //demo montlydata
  final MonthlyData _monthlyData = MonthlyData(
      month: DateTime.now().month,
      fullrentgivenondate: DateTime.now().day,
      partialrentgivenondate: DateTime.now().day,
      rentgivenby: "Shubham",
      paymentmethod: "CashPayment");

  final dbhelper = DatabaseHelper.instance;

  //insterting input from user as a row in database
  void insertdata() async {
    //firebase data
    FirebaseUserdata user = FirebaseUserdata(
      name: personName.text,
      age: age.text,
      rentgiven: rentgiven.toString(),
      monthlyrent: monthlyrent.text == 1 ? true : false,
      contactnumber: int.parse(contactno.text),
      rating: int.parse(trust.text),
      partialrentgiven: null,
    );
    user.addUser(
      personName.text,
      age.text,
      rentgiven.toString(),
      true,
      int.parse(contactno.text),
      int.parse(trust.text),
      null,
      _monthlyData,
    );
    user.addUsersMontlyData();
    //local data
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
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
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
              TextField(
                controller: contactno,
                decoration: const InputDecoration(
                  hintText: 'enter Contact Number',
                  labelText: 'Contact Number',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: trust,
                decoration: const InputDecoration(
                  hintText: 'What is the trust rating?',
                  labelText: 'Trust Rating',
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DateTimeField(
                format: format,
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text("Full Rent Staus: "),
                      Radio(
                          value: 1,
                          groupValue: rentradiogroup,
                          onChanged: (val) {
                            setState(() {
                              rentradiogroup = 1;
                              rentgiven = 1;
                            });
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
                            setState(() {
                              rentradiogroup = 0;
                              rentgiven = 0;
                            });
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
        ),
      ),
    );
  }
}

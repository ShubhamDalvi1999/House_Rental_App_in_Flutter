import 'package:database_curd_demo_app/FIrebaseAuth/authentication_service.dart';
import 'package:database_curd_demo_app/pages/customquery.dart';
import 'package:database_curd_demo_app/pages/delete.dart';
import 'package:database_curd_demo_app/pages/insert.dart';
import 'package:database_curd_demo_app/pages/viewall.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dbhelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbhelper = DatabaseHelper.instance;

  //insterting
  void insertdata() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: "Sing",
      DatabaseHelper.columnAge: 45,
      DatabaseHelper.columnMonthlyRent: 4000,
      DatabaseHelper.columnRentGiven: 1000,
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        centerTitle: true,
        // leading: CircleAvatar(
        //   child: Image.asset("assets/images/eevee.png"),
        //   radius: 25,
        // ),
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AuthenticationService>().signOut();
            },
            child: CircleAvatar(
              child: Image.asset("assets/images/logout-icon-png-3.jpg"),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture:
                  Image.asset("assets/images/person-logo.png"),
              accountName: const Text("Admin"),
              accountEmail: const Text("email")),
          const ListTile(
            leading: Icon(Icons.people),
            title: Text("All customers"),
          ),
          const ListTile(
            leading: Icon(Icons.people),
            title: Text("Search customers"),
          ),
          const ListTile(
            leading: Icon(Icons.people),
            title: Text("Update customers"),
          ),
          const ListTile(
            leading: Icon(Icons.people),
            title: Text("Delete customers"),
          ),
        ]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Insertdata()));
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
            child: const Text("Add a customer"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ViewAllRentals()));
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
            child: const Text("All rental data"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CustomQuery()));
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
            child: const Text("Search customer"),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Colors.purple,
              onSurface: Colors.grey,
              side: const BorderSide(color: Colors.black, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 20,
            ),
            child: const Text("Update customer data"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DeleteData()));
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
            child: const Text("Delete based on id"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset("assets/images/add-user.png"),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Insertdata()));
        },
      ),
    );
  }
}

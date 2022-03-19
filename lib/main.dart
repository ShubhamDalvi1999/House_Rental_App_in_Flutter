import 'package:database_curd_demo_app/FIrebaseAuth/authentication_service.dart';
import 'package:database_curd_demo_app/pages/AFTER%20LOGIN/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/BEFORE LOGIN/RegisterAndLogin.dart';

Future<void> main() async {
  //initialize firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //MultiProvider that merges multiple providers into a single linear widget tree

    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance)),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Database In Flutter Demo',
        theme: ThemeData.light(),
        home: AutenticationWrapper(),
      ),
    );
  }
}

class AutenticationWrapper extends StatelessWidget {
  const AutenticationWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    // ignore: unnecessary_null_comparison
    if (firebaseUser != null) {
      return HomePage();
    }
    return ToggleScreen(); //Login or Registration Page
  }
}

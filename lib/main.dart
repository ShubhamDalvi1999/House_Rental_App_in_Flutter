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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  //init state method to check internet connectivity and app close/running in background
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  //dispose method to avoid memory leak problems
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

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

class AutenticationWrapper extends StatefulWidget {
  const AutenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AutenticationWrapper> createState() => _AutenticationWrapperState();
}

class _AutenticationWrapperState extends State<AutenticationWrapper> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      //todo :if user is a normal user redirect to different pages
      //todo : if user is admin redirect to diff pages
      return HomePage();
    }
    return ToggleScreen(); //Login or Registration Page
  }
}

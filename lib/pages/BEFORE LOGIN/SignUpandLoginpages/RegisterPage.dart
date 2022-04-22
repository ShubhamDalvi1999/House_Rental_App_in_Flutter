import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:database_curd_demo_app/FIrebaseAuth/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleScreen;

  const RegisterPage({Key? key, required this.toggleScreen}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey =
      GlobalKey<FormState>(); //formkey to validate the form submitted
  bool changeButton = false;
  final GlobalKey<ScaffoldState> _scaffoldstate =
      GlobalKey<ScaffoldState>(); //Scaffoldstate to showw snackbar

  void _showSnackBar() async {
    _scaffoldstate.currentState?.showSnackBar(
        const SnackBar(content: Text("Registered Successfully")));
    await Future.delayed(
        const Duration(seconds: 50)); //created a custom wait to show snackbar
  }

  //for checking internet connectivity
  String status = "Waiting for internet connection";
  final Connectivity _connectivity = Connectivity();

  void checkConnectivity() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile) {
      status = "MobileData";
    } else if (connectionResult == ConnectivityResult.wifi) {
      status = "Wifi";
    } else {
      status = "Not connected to internet";
    }
    setState(() {});
    // if (this.mounted) {
    //   setState(() {
    //     // Your state change code goes here
    //     print("setstate called");
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, //formkey for validating data
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/login_image.png",
                      width: 258,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Row(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                    child: const Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
                      child: const Expanded(
                        child: Text(
                          "There Welcome",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      child: const Text(
                        ".",
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text("Create account to continue"),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 0.0),
                  child: Column(
                    children: [
                      //Username Field
                      TextFormField(
                        controller: usernameController,
                        validator: (value) {
                          //USERNAME VALIDATION
                          if (value!.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Montserrat',
                        ),
                        decoration: InputDecoration(
                          hintText: "Enter username",
                          labelText: "Username",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.shade400, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //Email Field
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          //EMAIL FIELD VALIDATION
                          if (value!.isEmpty) {
                            return "Email cannot be empty";
                          } else if (value.length < 6) {
                            return "Email length should be >6";
                          } else if (!value.contains("@gmail.com")) {
                            return "Email should end with @gmail.com";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Email",
                          labelText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.shade400, width: 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      //Password Field
                      TextFormField(
                        controller: passwordController,
                        validator: (value) {
                          //PASSWORD VALIDATION
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          } else if (value.length < 6) {
                            return "Password length should be >6";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter password",
                          labelText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.lightBlue.shade400, width: 1.0),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                          ),
                          //done : the label text on the box of input field
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                        ),
                        obscureText: true,
                        style: const TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                //REgister buttton
                ElevatedButton(
                    onPressed: () async {
                      if (status == "Not connected to internet") {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Not connected to internet"),
                          duration: Duration(milliseconds: 800),
                        ));
                      }

                      if (_formKey.currentState!.validate()) {
                        _showSnackBar();
                        String message =
                            // ignore: unnecessary_cast
                            await context.read<AuthenticationService>().signUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ) as String;
                        if (message
                            .startsWith("The email address is already")) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "The email address is already in use by another account."),
                            duration: Duration(milliseconds: 900),
                          ));
                        }
                      }
                    },
                    child: const Text("REGISTER")),

                //Registeration  (page change)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account ?",
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                        onPressed: () {
                          widget.toggleScreen();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:database_curd_demo_app/FIrebaseAuth/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final Function toggleScreen;

  const LoginPage({Key? key, required this.toggleScreen}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //Formkey to validate entered values
  String name = "";
  bool changeButton = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, //form validation
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
                      child: Expanded(
                        child: Text(
                          "There $name",
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: const TextStyle(
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
                          } else if (value.length < 3) {
                            return "Username should be greater than 3 char ";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          name = value;
                          setState(() {});
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
                                const BorderRadius.all(Radius.circular(20.0)),
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
                          //EMAIL VALIDATION
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

                //login buttton
                ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        String message =
                            // ignore: unnecessary_cast
                            await context.read<AuthenticationService>().signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ) as String;
                        if (message.startsWith("The password is invalid")) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("The password is invalid"),
                            duration: Duration(milliseconds: 900),
                          ));
                        } else if (message
                            .startsWith("There is no user record")) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("No Such User"),
                            duration: Duration(milliseconds: 900),
                          ));
                        }
                      }
                    },
                    child: const Text("Login")),

                //Registeration  (page change)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                        onPressed: () {
                          widget.toggleScreen();
                        },
                        child: const Text(
                          "Register",
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //signout functionality
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //Sign In functionality
  Future<String> signIn({String? email, String? password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      //print("THIS IS FIREBASE SIGNIN ERROR" + e.message.toString());
      return e.message.toString();
    }
  }

  //Sign Up functionality
  Future<String> signUp({String? email, String? password}) async {
    try {
      print("Registering User");
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      print("THIS IS FIREBASE SIGNUP ERROR" + e.message.toString());
      return e.message.toString();
    }
  }
}

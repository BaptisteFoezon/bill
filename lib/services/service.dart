import 'package:bill/Views/login_page.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/models/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'database.dart';

final auth = FirebaseAuth.instance;

loggeOut(context) {
  FirebaseAuth.instance.signOut();
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return const LoginPage();
  }));
}

register(String email, password, name, phone) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    UserApp _user = UserApp(
        id: auth.currentUser!.uid, nom: name, email: email, phone: phone);
    await DataBase().addUser(_user);
  } catch (e) {
    //depugPrint(e.toString());
  }
}

Future<String> signIn(String email, password, context) async {
  String message = "";
  try {
    debugPrint("sign in =>  go to NavScreen");
    auth.signInWithEmailAndPassword(email: email, password: password).then(
          (value) => {
            print(value),
            DataBase().getUser(value.user!.uid).then((user) => {
                  debugPrint(user.id),
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        //depugPrint("Material Page route");
                        return NavScreen(user: user, index: 0);
                      },
                    ),
                  )
                }),
          },
        );
  } catch (e) {
    message = getMessageFromErrorCode(e);
  }
  return message;
}

String getMessageFromErrorCode(e) {
  switch (e) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Server error, please try again later.";
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}

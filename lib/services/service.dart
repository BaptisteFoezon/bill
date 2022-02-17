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
    return LoginPage();
  }));
}

register(String email, password, name, phone) async {
  try {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
    UserApp _user = UserApp(
        id: auth.currentUser!.uid, nom: name, email: email, phone: phone);
    await DataBase().addUser(_user);
  } catch (e) {
    debugPrint(e.toString());
  }
}

signIn(String email, password, context) async {
  try {
    auth.signInWithEmailAndPassword(email: email, password: password).then(
          (value) => {
            DataBase().getUser(value.user!.uid).then((user) => {
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (context) {
                        return NavScreen(user: user, index: 0);
                      },
                    ),
                  )
                }),
          },
        );
  } catch (e) {
    debugPrint(e.toString());
  }
}

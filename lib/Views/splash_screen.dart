import 'dart:async';

import 'package:bill/Views/login_page.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        debugPrint("page ");
        DataBase().getUser(user.uid).then(
              (value) => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return NavScreen(user: value, index: 0);
                    },
                  ),
                )
              },
            );
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Loading(
      color: Colors.black,
    );
  }
}

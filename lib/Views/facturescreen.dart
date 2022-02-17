import 'package:bill/Views/widgets/customDrawer.dart';
import 'package:bill/models/user_app.dart';
import 'package:flutter/material.dart';

class FactureScreen extends StatelessWidget {
  UserApp user;
  FactureScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: customDrawer(user, context),
    );
  }
}

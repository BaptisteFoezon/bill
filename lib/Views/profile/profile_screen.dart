import 'package:bill/Views/widgets/customDrawer.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/service.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  UserApp user;
  ProfilScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => loggeOut(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: customDrawer(user, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const CircleAvatar(radius: 40),
                const SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.nom),
                    Text(user.phone),
                    Text(user.email),
                  ],
                )
              ],
            ),
            ElevatedButton.icon(
              onPressed: () => {},
              icon: const Icon(Icons.edit),
              label: const Text("Modifier"),
            )
          ],
        ),
      ),
    );
  }
}

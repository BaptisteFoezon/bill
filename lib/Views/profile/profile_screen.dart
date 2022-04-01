import 'package:bill/models/user_app.dart';
import 'package:flutter/material.dart';

class ProfilScreen extends StatelessWidget {
  UserApp user;
  ProfilScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: CircleAvatar(radius: 40)),
                    const SizedBox(height: 10),
                    LabelBold(
                      contenu: user.nom,
                      title: 'Nom: ',
                    ),
                    LabelBold(
                      contenu: user.phone,
                      title: 'Téléphone: ',
                    ),
                    LabelBold(
                      contenu: user.email,
                      title: 'Email: ',
                    ),
                    LabelBold(
                      contenu: user.id,
                      title: 'Id: ',
                    ),
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

class LabelBold extends StatelessWidget {
  const LabelBold({
    Key? key,
    required this.title,
    required this.contenu,
  }) : super(key: key);

  final String contenu;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(contenu),
      ],
    );
  }
}

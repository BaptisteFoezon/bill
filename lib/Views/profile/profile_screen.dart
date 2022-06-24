import 'package:bill/models/user_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../commons/widgets/profile_widget.dart';

class ProfilScreen extends StatelessWidget {
  UserApp user;
  ProfilScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imgPath,
            onClicked: () async {},
          ),
          const SizedBox(height: 10),
          buildName(user, context),
          ElevatedButton.icon(
            onPressed: () => {},
            icon: const Icon(Icons.edit),
            label: const Text("Modifier"),
          )
        ],
      ),
    );
  }
}

class ModifyProfilScreen extends StatefulWidget {
  UserApp user;
  ModifyProfilScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ModifyProfilScreen> createState() => _ModifyProfilScreenState();
}

class _ModifyProfilScreenState extends State<ModifyProfilScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileWidget(
      imagePath: widget.user.imgPath,
      onClicked: () async {},
    );
  }
}

Widget buildName(UserApp user, BuildContext context) => Column(
      children: [
        Text(
          user.nom,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          user.phone,
          style: const TextStyle(color: Colors.grey),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user.id,
              style: const TextStyle(color: Colors.grey),
            ),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: user.id));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Id copier dans le press papier"),
                  ),
                );
              },
              icon: const Icon(Icons.copy),
            ),
            IconButton(
              onPressed: () {
                Share.share(
                    "Voici mon Id sur l'application Bill : \n" + user.id);
              },
              icon: const Icon(Icons.share),
            ),
          ],
        ),
      ],
    );

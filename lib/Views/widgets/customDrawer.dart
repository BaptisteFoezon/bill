import 'package:bill/Views/login_page.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/models/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

customDrawer(UserApp user, BuildContext context) {
  return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hey !",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () => {},
            title: const Text(
              "Transfert",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.file_upload,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavScreen(
                    user: user,
                    index: 3,
                  ),
                ),
              ),
            },
            title: const Text(
              "Profil",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          ListTile(
            onTap: () => {
              FirebaseAuth.instance.signOut(),
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const LoginPage();
              }))
            },
            title: const Text(
              "Déconnexion",
              style: TextStyle(color: Colors.white),
            ),
            leading: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
          )
        ],
      ));
}

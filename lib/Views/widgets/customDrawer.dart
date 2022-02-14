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
          const DrawerHeader(child: Text("data")),
          ListTile(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NavScreen(
                    user: user,
                    index: 0,
                  ),
                ),
              ),
            },
            title: const Text(
              "Tableau de bord",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.dashboard,
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
                    index: 1,
                  ),
                ),
              ),
            },
            title: const Text(
              "Factures",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            leading: const Icon(
              Icons.file_copy,
              color: Colors.white,
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
                return LoginPage();
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

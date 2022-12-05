import 'package:bill/main.dart';
import 'package:bill/src/auth/auth_util.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/actions/transfert_car/transfert_car.dart';
import 'package:bill/src/views/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 200.0,
            child: Center(
              child: Text(
                'Bill',
                style: BillTheme.of(context).title2.override(
                      fontFamily: 'Outfit',
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.transfer_within_a_station),
            title: const Text('Transferer un véhicule'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TransfertCarScreen(),
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Mon profil'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBarPage(initialPage: 'Profil'),
                ),
              ),
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Réglages'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Déconnexion'),
            onTap: () => {
              signOut(),
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (r) => false,
              )
            },
          ),
        ],
      ),
    );
  }
}

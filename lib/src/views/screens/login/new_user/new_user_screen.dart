import 'package:bill/components/button.dart';
import 'package:bill/main.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:flutter/material.dart';

class NewUserScreen extends StatelessWidget {
  const NewUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CompleteUserInfoScreen();
  }
}

class CompleteUserInfoScreen extends StatelessWidget {
  const CompleteUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BillTheme.of(context).primaryBackground,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: const Text("complete profil when created acount"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FFButtonWidget(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingWelcomAppScreen(),
                  ),
                );
              },
              text: 'Suivant',
              options: FFButtonOptions(
                width: double.infinity,
                height: 50,
                color: BillTheme.of(context).primaryColor,
                textStyle: BillTheme.of(context).subtitle2.override(
                      fontFamily: 'Outfit',
                      color: BillTheme.of(context).primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                elevation: 3,
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingWelcomAppScreen extends StatefulWidget {
  const SettingWelcomAppScreen({super.key});

  @override
  State<SettingWelcomAppScreen> createState() => _SettingWelcomAppScreenState();
}

class _SettingWelcomAppScreenState extends State<SettingWelcomAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BillTheme.of(context).primaryBackground,
        iconTheme: IconThemeData(color: BillTheme.of(context).primaryColor),
      ),
      body: Column(
        children: [
          Container(
            child: const Text("Setting of application when created acount"),
          ),
          FFButtonWidget(
            onPressed: () async {
              await Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const NavBarPage(initialPage: 'HomePage'),
                ),
                (r) => false,
              );
            },
            text: 'Suivant',
            options: FFButtonOptions(
              width: double.infinity,
              height: 50,
              color: BillTheme.of(context).primaryColor,
              textStyle: BillTheme.of(context).subtitle2.override(
                    fontFamily: 'Outfit',
                    color: BillTheme.of(context).primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
              elevation: 3,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

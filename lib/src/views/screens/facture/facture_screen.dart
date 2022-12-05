import 'package:bill/src/bill/bill_theme.dart';
import 'package:flutter/material.dart';

class FactureScreen extends StatelessWidget {
  const FactureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

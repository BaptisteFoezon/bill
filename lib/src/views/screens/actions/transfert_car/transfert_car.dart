import 'package:bill/src/bill/bill_theme.dart';
import 'package:flutter/material.dart';

class TransfertCarScreen extends StatelessWidget {
  const TransfertCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillTheme.of(context).primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BillTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: BillTheme.of(context).primaryColor),
        title: const Text('Transferer un véhicule'),
      ),
      body: Container(),
    );
  }
}

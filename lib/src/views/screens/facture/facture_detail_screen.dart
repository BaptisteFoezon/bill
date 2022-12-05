import 'package:bill/src/backend/schema/factures_record.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:flutter/material.dart';

class FactureDetailScreen extends StatefulWidget {
  const FactureDetailScreen({super.key, required List<FacturesRecord> facture});

  @override
  State<FactureDetailScreen> createState() => _FactureDetailScreenState();
}

class _FactureDetailScreenState extends State<FactureDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillTheme.of(context).primaryBackground,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: BillTheme.of(context).primaryColor),
        backgroundColor: BillTheme.of(context).secondaryBackground,
        title: const Text('Detail de la facture'),
      ),
      body: Container(),
    );
  }
}

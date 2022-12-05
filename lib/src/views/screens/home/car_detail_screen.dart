import 'package:bill/src/backend/backend.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/facture/components/facture_list_component.dart';
import 'package:flutter/material.dart';

class CarDetailScreen extends StatefulWidget {
  final CarsRecord car;
  const CarDetailScreen({super.key, required this.car});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final car = widget.car;
    return Scaffold(
      backgroundColor: BillTheme.of(context).primaryBackground,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail du véhicule"),
        backgroundColor: BillTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: BillTheme.of(context).primaryColor),
      ),
      body: Column(
        children: [
          Center(
            child: Text(car.name!),
          ),
          const Text("Mes factures"),
          ListFactureWidget(car: car),
        ],
      ),
    );
  }
}

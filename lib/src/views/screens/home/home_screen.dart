import 'package:bill/src/bill/bill_theme.dart';
import 'package:bill/src/views/screens/home/components/actionsRapide/add_car_btn_widget.dart';
import 'package:bill/src/views/screens/home/components/actionsRapide/transfert_car_btn_widget.dart';
import 'package:bill/src/views/screens/home/components/car_list_component.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldHomeKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    const cardWidth = 190.0;
    return Scaffold(
      key: scaffoldHomeKey,
      backgroundColor: BillTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Text(
                "Mes véhicules",
                style: BillTheme.of(context).title2,
              ),
            ),
            const ListCarWidget(),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
              child: Text(
                "Actions rapides",
                style: BillTheme.of(context).title2,
              ),
            ),
            const AddCarButtonWidget(),
            const TransfertCarButtonWidget(),
          ],
        ),
      ),
    );
  }
}

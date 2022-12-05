import 'package:bill/components/button.dart';
import 'package:bill/src/auth/auth_util.dart';
import 'package:bill/src/backend/backend.dart';
import 'package:bill/src/bill/bill_theme.dart';
import 'package:flutter/material.dart';

import '../../../../models/car.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  TextEditingController? modelController;
  TextEditingController? nameController;

  @override
  void initState() {
    super.initState();
    modelController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    modelController!.dispose();
    nameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BillTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: BillTheme.of(context).secondaryBackground,
        iconTheme: IconThemeData(color: BillTheme.of(context).primaryColor),
        title: const Text('Ajouter un véhicule'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom du véhicule',
                ),
              ),
              TextFormField(
                controller: modelController,
                decoration: const InputDecoration(
                  labelText: 'Modèle du véhicule',
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final car = Car(
                      name: nameController!.text,
                      model: modelController!.text,
                      userId: currentUserUid,
                    );
                    await createCar(car);
                  },
                  text: 'Ajouter véhicule',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50,
                    color: Colors.white,
                    textStyle: BillTheme.of(context).subtitle2.override(
                          fontFamily: 'Outfit',
                          color: const Color(0xFF00A3FF),
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
        ),
      ),
    );
  }
}

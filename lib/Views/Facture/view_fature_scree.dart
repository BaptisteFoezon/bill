import 'package:bill/Views/Car/view_car.dart';
import 'package:bill/models/facture.dart';
import 'package:flutter/material.dart';

import '../../models/car.dart';
import '../../models/user_app.dart';
import 'facture_detail_screen.dart';

class ViewFacture extends StatelessWidget {
  String url;
  Facture facture;
  Car car;
  UserApp user;
  ViewFacture(
      {Key? key,
      required this.url,
      required this.car,
      required this.facture,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FactureDetailScreen(
                                car: car,
                                user: user,
                                facture: facture,
                              )),
                    )
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

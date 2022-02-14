import 'package:bill/models/facture.dart';
import 'package:bill/Views/Car/view_car.dart';
import 'package:bill/Views/home/home_page.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:flutter/material.dart';

class FactureDetailScreen extends StatelessWidget {
  Facture facture;
  Car car;
  UserApp user;

  FactureDetailScreen(
      {Key? key, required this.facture, required this.car, required this.user})
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
                          builder: (context) => viewCarScreen(
                                car: car,
                                user: user,
                              )),
                    )
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: const Drawer(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            const Text("aficher detail de la facture"),
            Text("Nom de la facture : " + facture.nom),
            Text("Id car : " + facture.carid),
            Text("date facture : " + facture.date.toUtc().toString()),
            Text("commentaire : " + facture.commentaire),
            Text("Id car : " + facture.carid),
            Text("Url scan :" + facture.scanurl)
          ],
        ),
      ),
    );
  }
}

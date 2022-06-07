import 'package:bill/Views/Facture/facture_detail_screen.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
import 'package:flutter/material.dart';

import '../../services/database.dart';
import '../commons/widgets/loading.dart';

class FactureScreen extends StatelessWidget {
  UserApp user;
  FactureScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Text(
              "Mes Factures",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<Facture>>(
                future: DataBase().getAllFactures(user),
                initialData: const <Facture>[],
                builder: (context, AsyncSnapshot<List<Facture>> factures) {
                  if (factures.hasData) {
                    //depugPrint("factures has data");
                    dynamic factureList = factures.data;
                    return Scrollbar(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: factures.data!.length,
                          itemBuilder: (context, index) {
                            Facture facture;
                            return GestureDetector(
                              onTap: () => {
                                facture = Facture(
                                    nom: factures.data![0].nom,
                                    date: factures.data![0].date,
                                    commentaire: factures.data![0].commentaire,
                                    carid: factures.data![0].carid,
                                    scanurl: factures.data![0].scanurl,
                                    factureid: factures.data![0].factureid),
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return FactureDetailScreen(
                                      facture: facture,
                                      car: Car(
                                          marque: "marque",
                                          annee: "année",
                                          modele: "modèle",
                                          userId: "userId",
                                          nbKilometre: "nbKilomètre",
                                          numImmatriculation:
                                              "numImmatriculation",
                                          numChassi: "numChâssis"),
                                      user: user);
                                }))
                              },
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.all(5),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          factures.data![index].date.day
                                                  .toString() +
                                              "/" +
                                              factures.data![index].date.month
                                                  .toString() +
                                              "/" +
                                              factures.data![index].date.year
                                                  .toString(),
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        Text(
                                          factures.data![index].nom,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Loading(color: Colors.transparent);
                  }
                }),
          )
        ],
      ),
    );
  }
}

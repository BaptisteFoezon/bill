import 'package:bill/Views/Car/add_car.dart';
import 'package:bill/Views/home/widget/emptycard.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/Views/widgets/customDrawer.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/models/car.dart';
import 'package:bill/Views/home/widget/car_list.dart';
import 'package:bill/Views/home/widget/hello_text.dart';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/services/database.dart';
import 'package:bill/services/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bill/models/user_app.dart';

class HomeScreen extends StatelessWidget {
  UserApp user;
  HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Car _testCar = Car(
      marque: "marque",
      annee: "annee",
      modele: "modele",
      userId: user.id,
      nbKilometre: '',
      numChassi: '',
      numImmatriculation: '',
    );
    double maxwith = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => loggeOut(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      drawer: customDrawer(user, context),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HelloText(name: user.nom),
            const Text(
              "Mes voitures: ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            CarList(userApp: user),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Actions rapides :",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(maxwith - 16, 20),
                primary: Colors.black,
              ),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AddCarScreen(user: user);
                    },
                  ),
                )
              },
              icon: const Icon(Icons.car_rental),
              label: const Text("Ajouter une voiture"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(maxwith - 16, 20),
                primary: Colors.black,
              ),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      debugPrint("Material Page route");
                      return NavScreen(user: user, index: 2);
                    },
                  ),
                )
              },
              icon: const Icon(Icons.file_download),
              label: const Text("Ajouter une facture"),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(maxwith - 16, 20),
                primary: Colors.black,
              ),
              onPressed: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      debugPrint("Material Page route");
                      return NavScreen(user: user, index: 1);
                    },
                  ),
                )
              },
              icon: const Icon(Icons.file_copy),
              label: const Text("Voir mes factures"),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingSquellette extends StatelessWidget {
  const LoadingSquellette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxwidth = (MediaQuery.of(context).size.width - 80) / 3;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          CardEmpty(
            height: 50,
            width: 200,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Mes voitures: ", style: TextStyle(color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              CardEmpty(
                height: maxwidth,
                width: maxwidth,
              ),
              const SizedBox(
                width: 20,
              ),
              CardEmpty(
                height: maxwidth,
                width: maxwidth,
              ),
              const SizedBox(
                width: 20,
              ),
              CardEmpty(
                height: maxwidth,
                width: maxwidth,
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataBase {
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //Add user
  Future<void> addUser(UserApp user) async {
    await userCollection.doc(user.id).set({
      "name": user.nom,
      "id": user.id,
      "email": user.email,
    });
  }

  Future<UserApp> getUser(String userid) async {
    dynamic test = await userCollection.doc(userid).get();
    debugPrint(test.toString());
    return UserApp(
        id: test['id'],
        nom: test['name'],
        email: test['email'],
        phone: test['phone']);
  }

  //Modify User info

  // add new car
  Future<void> addCar(UserApp user, Car car) async {
    await userCollection.doc(user.id).collection("Cars").add({
      "marque": car.marque,
      "modele": car.modele,
      "annee": car.annee,
      "userId ": car.userId,
      "N°chasis": car.numChassi,
      "immatriculation": car.numImmatriculation,
      "nbkilometre": car.nbKilometre,
      "carId": "",
    });
  }

  //get list of use car

  Future<List<Car>> getCars(UserApp user) async {
    debugPrint("get cars ....");
    List<Car> cars = [];
    await userCollection.doc(user.id).collection("Cars").get().then((value) => {
          for (dynamic item in value.docs)
            {
              cars.add(Car(
                marque: item["marque"],
                annee: item["annee"],
                modele: item["modele"],
                carId: item.id,
                userId: user.id,
                nbKilometre: item["nbkilometre"],
                numChassi: item["N°chasis"],
                numImmatriculation: item["immatriculation"],
              ))
            }
        });
    return cars;
  }

  Map<dynamic, dynamic> getMapCars(UserApp user) {
    final Map carsMap = <String, Car>{};
    debugPrint("get cars ....");
    userCollection.doc(user.id).collection("Cars").get().then((value) => {
          for (dynamic item in value.docs)
            {
              carsMap[item["modele"]] = Car(
                marque: item["marque"],
                annee: item["annee"],
                modele: item["modele"],
                carId: item.id,
                userId: user.id,
                nbKilometre: item["nbkilometre"],
                numChassi: item["N°chasis"],
                numImmatriculation: item["immatriculation"],
              )
            }
        });
    return carsMap;
  }

  Future<List<Facture>> getFactures(UserApp user, Car car) async {
    debugPrint("get facture ....");
    List<Facture> factures = [];
    await userCollection
        .doc(user.id)
        .collection("Cars")
        .doc(car.carId)
        .collection("Factures")
        .get()
        .then((value) => {
              for (dynamic item in value.docs)
                {
                  debugPrint("Facture from firebase :"),
                  debugPrint(item["scanurl"]),
                  debugPrint(item["nom"]),
                  debugPrint(item["carid"]),
                  debugPrint(item["data"]),
                  factures.add(
                    Facture(
                      nom: item["nom"],
                      carid: item["carid"],
                      commentaire: item["commentaire"],
                      date: DateTime.now(),
                      scanurl: item["scanurl"],
                    ),
                  )
                }
            });
    return factures;
  }
  // Modify car info

  // Add facrure

  Future<void> addFacture(UserApp user, Facture facture) async {
    await userCollection.doc(user.id).collection("Factures").add({
      "carid": facture.carid,
      "date": facture.date,
    });
  }
  // modify factures

  // get all factures from all the car
}

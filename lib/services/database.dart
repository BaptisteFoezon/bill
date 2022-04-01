import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
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
    print("get user");
    dynamic test = await userCollection.doc(userid).get();
    print("test");
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
    await userCollection.doc(user.id).collection("Cars").doc(car.carId).set({
      "marque": car.marque,
      "modele": car.modele,
      "annee": car.annee,
      "userId ": user.id,
      "N°chasis": car.numChassi,
      "immatriculation": car.numImmatriculation,
      "nbkilometre": car.nbKilometre,
      "carId": car.carId,
    });
  }

  Future<void> transfertCar(
      UserApp user, String usertransfert, String carId) async {
    UserApp userTransfert =
        UserApp(id: usertransfert, nom: "nom", email: "email", phone: "phone");
    Car car = await getCarFromID(carId, user);
    car.userId = usertransfert;
    car.urlassurance = "";
    car.urlcartegrise = "";
    List<Facture> factures = await getAllFactures(user);
    for (dynamic item in factures) {
      Facture facture;
      facture = item;
      facture.carid = carId;
      addFacture(userTransfert, facture);
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection("Factures")
          .doc(facture.factureid)
          .delete();
    }
    addCar(userTransfert, car);
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Cars")
        .doc(carId)
        .delete();
  }

  //get list of use car

  Stream<QuerySnapshot> getCarStream(UserApp user) {
    return userCollection.doc(user.id).collection("Cars").snapshots();
  }

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
                  factures.add(
                    Facture(
                        nom: item["nom"],
                        carid: item["carid"],
                        commentaire: item["commentaire"],
                        date: item["date"].toDate(),
                        scanurl: item["scanurl"],
                        factureid: item["factureid"]),
                  )
                }
            });
    return factures;
  }

  Future<List<Facture>> getAllFactures(UserApp user) async {
    debugPrint("get facture ....");
    List<Facture> factures = [];
    await userCollection
        .doc(user.id)
        .collection("Factures")
        .get()
        .then((value) => {
              for (dynamic item in value.docs)
                {
                  debugPrint("Facture from firebase :"),
                  debugPrint(item["scanurl"]),
                  debugPrint(item["nom"]),
                  debugPrint(item["carid"]),
                  factures.add(
                    Facture(
                        nom: item["nom"],
                        carid: item["carid"],
                        commentaire: item["commentaire"],
                        date: item["date"].toDate(),
                        scanurl: item["scanurl"],
                        factureid: item["factureid"]),
                  )
                }
            });
    return factures;
  }
  // Modify car info

  // Add facrure

  Future<void> deleteFacture(UserApp user, String carId, docId) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Cars")
        .doc(carId)
        .collection("Factures")
        .doc(docId)
        .delete();
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Factures")
        .doc(docId)
        .delete();
  }

  Future<void> addFacture(UserApp user, Facture facture) async {
    String docid = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Factures")
        .add({}).then((docRef) => {
              docid = docRef.id,
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.id)
                  .collection("Factures")
                  .doc(docRef.id)
                  .set(
                {
                  "nom": facture.nom,
                  "carid": facture.carid,
                  "date": facture.date,
                  "scanurl": facture.scanurl,
                  "commentaire": facture.commentaire,
                  "factureid": docRef.id,
                },
              )
            });
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Cars")
        .doc(facture.carid)
        .collection("Factures")
        .doc(docid)
        .set(
      {
        "nom": facture.nom,
        "carid": facture.carid,
        "date": facture.date,
        "scanurl": facture.scanurl,
        "commentaire": facture.commentaire,
        "factureid": docid,
      },
    );
    await userCollection.doc(user.id).collection("Factures").add({
      "carid": facture.carid,
      "date": facture.date,
    });
  }

  Future<Car> getCarFromID(String idCar, UserApp user) async {
    debugPrint("id voiture transfé " + idCar);
    dynamic car =
        await userCollection.doc(user.id).collection("Cars").doc(idCar).get();

    return Car(
        marque: car['marque'],
        annee: car['annee'],
        modele: car['modele'],
        userId: user.id,
        nbKilometre: car['nbkilometre'],
        numImmatriculation: car['immatriculation'],
        numChassi: car['N°chasis']);
  }
}

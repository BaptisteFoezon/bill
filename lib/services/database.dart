import 'dart:developer';

import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return UserApp(
        id: test['id'],
        nom: test['name'],
        email: test['email'],
        phone: test['phone']);
  }

  //Modify User info

  Future<void> addCar(UserApp user, Car car) async {
    String docid = '';
    await userCollection
        .doc(user.id)
        .collection("Cars")
        .add({}).then((docRef) => {
              docid = docRef.id,
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.id)
                  .collection("Cars")
                  .doc(docid)
                  .set(
                {
                  "marque": car.marque,
                  "modele": car.modele,
                  "annee": car.annee,
                  "userId ": user.id,
                  "N°chasis": car.numChassi,
                  "immatriculation": car.numImmatriculation,
                  "nbkilometre": car.nbKilometre,
                  "carId": docid,
                },
              )
            });
  }

  Future<void> transfertCar(
      UserApp user, String usertransfertid, String carId) async {
    UserApp userTransfert = UserApp(
        id: usertransfertid, nom: "nom", email: "email", phone: "phone");
    Car car = await getCarFromID(carId, user);
    car.userId = userTransfert.id;
    car.urlassurance = "";
    car.urlcartegrise = "";
    car.carId = carId;
    //ajout de la voiture au nouveau propriétaire
    await addCarTransfert(userTransfert, car);
    List<Facture> factures = await getFactures(user, car);
    for (dynamic item in factures) {
      Facture facture;
      facture = item;
      facture.carid = carId;
      //ajout des factures au nouveau propriétaire
      await addFacture(userTransfert, facture);
      //supression des factures de l'utilisateur initial
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection("Factures")
          .doc(facture.factureid)
          .delete();
    }
    // supression de la voiture de l'ancien prorietaire
    FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Cars")
        .doc(carId)
        .delete();
  }

  // add new car
  Future<void> addCarTransfert(UserApp user, Car car) async {
    String docid = '';
    await userCollection.doc(user.id).collection("Cars").doc(car.carId).set(
      {
        "marque": car.marque,
        "modele": car.modele,
        "annee": car.annee,
        "userId ": user.id,
        "N°chasis": car.numChassi,
        "immatriculation": car.numImmatriculation,
        "nbkilometre": car.nbKilometre,
        "carId": docid,
      },
    );
  }

  //get list of use car

  Stream<QuerySnapshot> getCarStream(UserApp user) {
    return userCollection.doc(user.id).collection("Cars").snapshots();
  }

  Future<List<Car>> getCars(UserApp user) async {
    //depugPrint("get cars ....");
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
    //depugPrint("get cars ....");
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
    RevisionFacture revison;
    List<Facture> factures = [];
    log(user.id);
    log(car.carId);
    Facture facture;
    await userCollection
        .doc(user.id)
        .collection("Cars")
        .doc(car.carId)
        .collection("Factures")
        .get()
        .then((value) => {
              log("get factures"),
              for (dynamic item in value.docs)
                {
                  facture = Facture(
                    nom: item["nom"],
                    carid: item["carid"],
                    commentaire: item["commentaire"],
                    date: item["date"].toDate(),
                    scanurl: item["scanurl"],
                    factureid: item["factureid"],
                  ),
                  if (item["révision"] != "null")
                    {
                      log(item["révision"].toString()),
                      facture.revisionFacture =
                          RevisionFacture().fromMap(item["révision"]),
                    },
                  if (item["pneumatique"] != "null")
                    {
                      log(item["pneumatique"].toString()),
                      facture.pneumatiqueFacture =
                          PneumatiqueFacture().fromMap(item["pneumatique"]),
                    },
                  log(item.toString()),
                  factures.add(
                    facture,
                  )
                }
            });
    return factures;
  }

  Future<List<Facture>> getAllFactures(UserApp user) async {
    //depugPrint("get facture ....");
    List<Facture> factures = [];
    await userCollection
        .doc(user.id)
        .collection("Factures")
        .get()
        .then((value) => {
              for (dynamic item in value.docs)
                {
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

  Future<void> addFacture(UserApp user, Facture facture,
      [RevisionFacture? revisionFacture,
      PneumatiqueFacture? pneumatiqueFacture,
      FreinageFacture? freinageFacture,
      ControleTechniqueFacture? controleTechniqueFacture]) async {
    String docid = '';

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .collection("Factures")
        .add({}).then((docRef) => {
              docid = docRef.id,
              facture.factureid = docid,
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.id)
                  .collection("Factures")
                  .doc(docid)
                  .set(
                {
                  "nom": facture.nom,
                  "carid": facture.carid,
                  "date": facture.date,
                  "scanurl": facture.scanurl,
                  "commentaire": facture.commentaire,
                  "factureid": docRef.id,
                  "révision": revisionFacture == null
                      ? "null"
                      : revisionFacture.toMap(),
                  "pneumatique": pneumatiqueFacture == null
                      ? "null"
                      : pneumatiqueFacture.toMap(),
                  "freinage": freinageFacture == null
                      ? "null"
                      : freinageFacture.toMap(),
                  "controle technique": controleTechniqueFacture == null
                      ? "null"
                      : controleTechniqueFacture.toMap(),
                },
              )
            });
    await FirebaseFirestore.instance
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
        "révision": revisionFacture == null ? "null" : revisionFacture.toMap(),
        "pneumatique":
            pneumatiqueFacture == null ? "null" : pneumatiqueFacture.toMap(),
      },
    );
  }

  Future<Car> getCarFromID(String idCar, UserApp user) async {
    //depugPrint("id voiture transfé " + idCar);
    dynamic car =
        await userCollection.doc(user.id).collection("Cars").doc(idCar).get();

    return Car(
        marque: car['marque'],
        annee: car['annee'],
        modele: car['modele'],
        userId: user.id,
        nbKilometre: car['nbkilometre'],
        numImmatriculation: car['immatriculation'],
        numChassi: car['N°chasis'],
        carId: car['carId']);
  }
}

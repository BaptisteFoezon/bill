import 'package:bill/Views/Facture/view_fature_scree.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/Views/Car/view_car.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/customDrawer.dart';

// ignore: must_be_immutable
class FactureDetailScreen extends StatefulWidget {
  Facture facture;
  Car car;
  UserApp user;

  FactureDetailScreen(
      {Key? key, required this.facture, required this.car, required this.user})
      : super(key: key);

  @override
  State<FactureDetailScreen> createState() => _FactureDetailScreenState();
}

class _FactureDetailScreenState extends State<FactureDetailScreen> {
  Future<String> downloadurl(String imagename) async {
    debugPrint(imagename);
    String downloadurl =
        await FirebaseStorage.instance.ref("files/$imagename").getDownloadURL();
    return downloadurl;
  }

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
                                car: widget.car,
                                user: widget.user,
                              )),
                    )
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: customDrawer(widget.user, context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Facture : " + widget.facture.nom,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                  "date facture : " + widget.facture.date.toLocal().toString()),
              const Text("commentaire : "),
              Text(widget.facture.commentaire),
              Center(
                child: widget.facture.scanurl == ""
                    ? Container()
                    : FutureBuilder(
                        future: downloadurl(widget.facture.scanurl),
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return TextButton.icon(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewFacture(
                                      url: snapshot.data!,
                                      facture: widget.facture,
                                      car: widget.car,
                                      user: widget.user,
                                    ),
                                  ),
                                ),
                              },
                              icon: const Icon(Icons.remove_red_eye),
                              label: const Text("voir la facture"),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {}
                          return Container();
                        }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text("Modifier"),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      showAlertDialog(context, widget.user, widget.car.carId,
                          widget.facture.factureid);
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text("Suprimer"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(
    BuildContext context, UserApp user, String carId, String docId) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Annuler"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Suprimer"),
    onPressed: () {
      Navigator.of(context).pop();
      DataBase().deleteFacture(user, carId, docId);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NavScreen(
            user: user,
            index: 0,
          ),
        ),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Attention !"),
    content: const Text("Voulez vous vraiment suprimer cette facture ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

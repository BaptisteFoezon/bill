import 'package:bill/Views/Facture/view_facture_screen.dart';
import 'package:bill/Views/nav_screen.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/Views/Car/view_car.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../commons/widgets/customDrawer.dart';

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
  late List<Item> _books;

  Future<String> downloadurl(String imagename) async {
    //depugPrint(imagename);
    String downloadurl =
        await FirebaseStorage.instance.ref("files/$imagename").getDownloadURL();
    return downloadurl;
  }

  @override
  void initState() {
    _books = [
      Item(
        expandedValue: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: widget.facture.revisionFacture != null
              ? detailRevision(widget.facture.revisionFacture!)
              : const Text("pas de détailles"),
        ),
        headerValue: "Révision",
      ),
      Item(
          expandedValue: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: widget.facture.pneumatiqueFacture != null
                ? detailPneumatique(widget.facture.pneumatiqueFacture!)
                : const Text("pas de détailles"),
          ),
          headerValue: "Pneumatique"),
      Item(
          expandedValue: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: widget.facture.pneumatiqueFacture != null
                ? detailPneumatique(widget.facture.pneumatiqueFacture!)
                : const Text("pas de détailles"),
          ),
          headerValue: "Freinage"),
      Item(
          expandedValue: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: widget.facture.pneumatiqueFacture != null
                ? detailPneumatique(widget.facture.pneumatiqueFacture!)
                : const Text("pas de détailles"),
          ),
          headerValue: "Contrôle technique"),
      Item(
          expandedValue: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: widget.facture.pneumatiqueFacture != null
                ? detailPneumatique(widget.facture.pneumatiqueFacture!)
                : const Text("pas de détailles"),
          ),
          headerValue: "Electricite"),
    ];
    super.initState();
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  height: 30,
                ),
                LabelBold(
                    title: "date facture : ",
                    contenu: DateFormat('dd/MM/yyyy')
                        .format(widget.facture.date.toLocal())
                        .toString()),
                const LabelBold(title: "commentaire : ", contenu: ""),
                Text(widget.facture.commentaire),
                const SizedBox(
                  height: 40,
                ),
                _buildPanel(_books),
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
                      label: const Text("supprimer"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPanel(_books) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _books[index].isExpanded = !isExpanded;
        });
      },
      children: _books.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: item.expandedValue,
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

Widget detailRevision(RevisionFacture widget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text("Filtre"),
      Row(
        children: [
          Checkbox(value: widget.huileB, onChanged: null),
          const Text("huile"),
          Checkbox(value: widget.pollenB, onChanged: null),
          const Text("pollen/habitacle"),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.airB, onChanged: null),
          const Text("air"),
          Checkbox(value: widget.carburantB, onChanged: null),
          const Text("Carburant"),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.freinB, onChanged: null),
          const Text("liquide de frein"),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.transmitionB, onChanged: null),
          const Text("liquide de transmission"),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.boitevitesseB, onChanged: null),
          const Text("huile de boîte de vitesse"),
        ],
      ),
      Row(
        children: [
          Checkbox(
            value: widget.refroidissementB,
            onChanged: null,
          ),
          const Text("huile de refroidissement"),
        ],
      )
    ],
  );
}

Widget detailPneumatique(PneumatiqueFacture widget) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Center(child: Text("Pneumatique")),
      const Text("Filtre"),
      Row(
        children: [
          Checkbox(value: widget.avantB, onChanged: null),
          const Text("avant"),
          Checkbox(value: widget.arriereB, onChanged: null),
          const Text("arriere"),
        ],
      ),
      Row(
        children: [
          const Text("Marque des pneus :"),
          Text(widget.marque ?? " "),
        ],
      ),
      Row(
        children: [
          const Text("Nombre"),
          Checkbox(value: widget.twoB, onChanged: null),
          const Text("2"),
          Checkbox(value: widget.fourB, onChanged: null),
          const Text("4"),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.pneuHiverB, onChanged: null),
          const Text("Pneu hiver"),
        ],
      ),
      Row(
        children: [
          const Text("Dimension :"),
          Text(widget.dimension ?? " "),
        ],
      ),
      Row(
        children: [
          Checkbox(value: widget.geometrieB, onChanged: null),
          const Text("Géométrie"),
        ],
      )
    ],
  );
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
    child: const Text("supprimer"),
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
    content: const Text("Voulez vous vraiment supprimer cette facture ?"),
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

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

class LabelBold extends StatelessWidget {
  const LabelBold({
    Key? key,
    required this.title,
    required this.contenu,
  }) : super(key: key);

  final String contenu;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(contenu),
      ],
    );
  }
}

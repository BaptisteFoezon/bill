import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../nav_screen.dart';
import '../scan/scan_screen.dart';
import '../widgets/customDrawer.dart';

class TransfertScreen extends StatefulWidget {
  UserApp user;
  TransfertScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TransfertScreen> createState() => _TransfertScreenState();
}

class _TransfertScreenState extends State<TransfertScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  bool istransfere = false;

  String? value;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MyData data = MyData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          user: widget.user,
                          index: 0,
                        ),
                      ),
                    )
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: customDrawer(widget.user, context),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const Text("Transfert"),
            !istransfere
                ? Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.user.id)
                              .collection("Cars")
                              .snapshots(),
                          builder: (context, snapshot) {
                            List<DropdownMenuItem<String>> currencyItems = [];
                            if (!snapshot.hasData) {
                              const Text("loading");
                            } else {
                              for (int i = 0;
                                  i < snapshot.data!.docs.length;
                                  i++) {
                                DocumentSnapshot snap = snapshot.data!.docs[i];
                                Map<String, dynamic> data =
                                    snap.data() as Map<String, dynamic>;
                                currencyItems.add(
                                  DropdownMenuItem<String>(
                                    value: snap.id,
                                    child: Text(data["modele"]),
                                  ),
                                );
                              }
                            }
                            return DropdownButtonFormField<dynamic>(
                              decoration: const InputDecoration(
                                labelText:
                                    'Sélectionner véhicule à selectionner',
                              ),
                              items: currencyItems.toList(),
                              value: value,
                              onChanged: (value) {
                                setState(
                                  () {
                                    this.value = value;
                                  },
                                );
                              },
                            );
                          },
                        ),
                        TextFormField(
                          controller: idController,
                          decoration: const InputDecoration(
                            labelText: 'Id de l\'utilisateur ',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuiller renseigner un ID valide';
                            }
                            return null;
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            String id = idController.value.text;
                            if (_formKey.currentState!.validate()) {
                              dynamic test = showAlertDialog(
                                  context, widget.user, value!, id);
                              istransfere = true;
                            }
                          },
                          child: const Text('Transferer'),
                        ),
                      ],
                    ),
                  )
                : const Text("transfert réussi"),
          ],
        ),
      )),
    );
  }
}

showAlertDialog(
    BuildContext context, UserApp user, String carId, String idTransfert) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Annuler"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Confirmer"),
    onPressed: () {
      // transferer documemnet
      // recuperer le document de l'user
      // l'ajouter au nouvelle utilisateur
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Loading()),
      );
      DataBase().transfertCar(user, idTransfert, carId);
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
    content: const Text("Voulez vous vraiment Transfer ce véhicule ?"),
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

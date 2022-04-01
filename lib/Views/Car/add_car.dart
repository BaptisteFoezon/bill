import 'package:bill/Views/nav_screen.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:flutter/material.dart';

import '../widgets/customDrawer.dart';

class AddCarScreen extends StatelessWidget {
  UserApp user;
  AddCarScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavScreen(
                          user: user,
                          index: 0,
                        ),
                      ),
                    ),
                  },
              icon: const Icon(Icons.arrow_back))
        ],
      ),
      drawer: customDrawer(user, context),
      body: Container(
        child: Center(
          child: Column(
            children: [
              AddForm(
                user: user,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddForm extends StatefulWidget {
  UserApp user;
  AddForm({Key? key, required this.user}) : super(key: key);

  @override
  _AddFormState createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController modeleController = TextEditingController();
  final TextEditingController marqueController = TextEditingController();
  final TextEditingController immatriculationController =
      TextEditingController();
  final TextEditingController chassiController = TextEditingController();
  final TextEditingController nbkilometreController = TextEditingController();
  final TextEditingController anneeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    modeleController.dispose();
    marqueController.dispose();
    immatriculationController.dispose();
    chassiController.dispose();
    nbkilometreController.dispose();
    anneeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Text(
            "Ajouter une voiture",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Form(
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      label: Text("name"), hintText: "nom de la voiture"),
                ),
                TextFormField(
                  controller: modeleController,
                  decoration: const InputDecoration(
                      label: Text("Modele"), hintText: "modele"),
                ),
                TextFormField(
                  controller: marqueController,
                  decoration: const InputDecoration(
                      label: Text("Marque"), hintText: "marque"),
                ),
                TextFormField(
                  controller: anneeController,
                  decoration: const InputDecoration(
                      label: Text("Annee"), hintText: "annee"),
                ),
                TextFormField(
                  controller: immatriculationController,
                  decoration: const InputDecoration(
                      label: Text("immatricumation"),
                      hintText: "immatriculation"),
                ),
                TextFormField(
                  controller: nbkilometreController,
                  decoration: const InputDecoration(
                      label: Text("Nb de kilommetre"),
                      hintText: "nb de kilometre"),
                ),
                TextFormField(
                  controller: chassiController,
                  decoration: const InputDecoration(
                      label: Text("N° de chassis"), hintText: "XXXXXXXXXX"),
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () => {
                          DataBase().addCar(
                            widget.user,
                            Car(
                              marque: marqueController.text,
                              annee: anneeController.text,
                              modele: modeleController.text,
                              userId: widget.user.id,
                              nbKilometre: nbkilometreController.text,
                              numImmatriculation: modeleController.text,
                              numChassi: modeleController.text,
                            ),
                          ),
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavScreen(
                                user: widget.user,
                                index: 0,
                              ),
                            ),
                          ),
                        },
                    icon: const Icon(Icons.add),
                    label: const Text("Ajouter ma voiture"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

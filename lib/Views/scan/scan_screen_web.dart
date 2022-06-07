/* import 'dart:async';
import 'dart:html';import 'dart:typed_data';
import 'package:bill/Views/widgets/loading.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/Views/widgets/responsive.dart';
import 'package:bill/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class PhotoScreen extends StatefulWidget {
  UserApp user;
  Car? car;
  Map cars;
  PhotoScreen({Key? key, required this.user, required this.cars, this.car})
      : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class MyData {
  String voiture = '';
  DateTime date = DateTime.now();
  String garage = '';
  String departement = '';
  String commentaire = '';
  String carId = '';
  String nom = '';
  String url = '';
}

class _PhotoScreenState extends State<PhotoScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Uint8List displayImage;
  late File uploadImage;
  //final picker = ImagePicker();
  bool loading = false;
  bool transfertOk = false;

  Future getImage() async {
    FileUploadInputElement? pickedFile = FileUploadInputElement();
    pickedFile.accept = '.png,.jpg';
    pickedFile.click();
    pickedFile.onChange.listen(((e) {
      final files = pickedFile.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();
        reader.onLoadEnd.listen((e) async {
          setState(() {
            uploadImage = reader.result as File;
            displayImage = reader.result as Uint8List;
          });
        });
      }
    }));
  }

  Future<void> uploadFile(String destination, File uploadFile) async {

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref(destination).child('files/${DateTime.now()}.png}')
          .putFile(uploadFile);
    } on firebase_core.FirebaseException {
      //depugPrint("error !!!!!!!!");
      //depugPrint(e.toString());
    }
  }

  Future<void> uploadFileWeb(String destination, Blob file) async {
    fs.FirebaseStorage.instance
        .refFromURL("gs://bill-app-44182.appspot.com/")
        .child("files/")
        .putBlob(file);
  }

  String dropdownCategorieValue = "Choisissez catégorie";
  DateTime? dateTime = DateTime.now();
  Car? carSelected;
  String? value;
  bool revisionSelect = false;
  bool pneumatiqueSelect = false;
  bool freinageSelect = false;
  bool controleTechniqueSelect = false;
  bool electriciteSelect = false;
  bool couroieSelect = false;
  bool embrayageSelect = false;
  bool suspensionSelect = false;
  late Blob blob;

  static MyData data = MyData();

  List<Step> stepList(bool isDesktop) => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Scanner'),
          content: Center(
            child: Container(
              child: kIsWeb
                  ? TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text("data"))
                  : Column(
                      children: [
                        Container(
                          child: _image.path.isEmpty
                              ? const Text("Pas de facture selectionné")
                              : kIsWeb
                                  ? Text(basename(_image.toString()))
                                  : Image.file(_image),
                        ),
                        TextButton.icon(
                          onPressed: () async => getImage(ImageSource.gallery),
                          icon: const Icon(Icons.file_download),
                          label: const Text("importer depuis votre galerie"),
                        )
                      ],
                    ),
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Information'),
          content: Container(
            child: StreamBuilder<QuerySnapshot>(
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
                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
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

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<dynamic>(
                      decoration: const InputDecoration(
                        labelText: 'Voiture',
                      ),
                      items: currencyItems.toList(),
                      value: value,
                      onSaved: (value) {
                        data.carId = value;
                      },
                      onChanged: (value) {
                        setState(
                          () {
                            this.value = value;
                          },
                        );
                      },
                    ),
                    InputDatePickerFormField(
                      fieldLabelText: 'Date',
                      fieldHintText: DateTime.now().day.toString() +
                          "/" +
                          DateTime.now().month.toString() +
                          "/" +
                          DateTime.now().year.toString(),
                      firstDate: DateTime(1998),
                      lastDate: DateTime(2222),
                      onDateSaved: (date) {
                        //depugPrint("value");
                        dateTime = date;

                        data.date = date;
                      },
                      onDateSubmitted: (date) {
                        //depugPrint("value");
                        data.date = date;
                      },
                      errorFormatText:
                          "La date n'est pas dans un format valide",
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          labelText: "Titre de la facture"),
                      onSaved: (value) {
                        data.nom = value ?? " ";
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Nom du garage"),
                      onSaved: (value) {
                        data.garage = value ?? " ";
                      },
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Departement"),
                      onSaved: (value) => data.departement = value ?? "",
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Commentaire"),
                      onSaved: (value) => data.commentaire = value ?? "",
                    )
                  ],
                );
              },
            ),
          ),
        ),
        Step(
          state: StepState.editing,
          isActive: _activeStepIndex >= 2,
          title: const Text('Details'),
          content: SizedBox(
              height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (() {
                      revisionSelect = !revisionSelect;
                      setState(() {});
                    }),
                    child: ContainerSelcted(
                      select: revisionSelect,
                      titre: "Revision",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      pneumatiqueSelect = !pneumatiqueSelect;
                      setState(() {});
                    }),
                    child: ContainerSelcted(
                      select: pneumatiqueSelect,
                      titre: "Pneumatique",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      freinageSelect = !freinageSelect;
                      setState(() {});
                    }),
                    child: ContainerSelcted(
                      select: freinageSelect,
                      titre: "Freinage",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      controleTechniqueSelect = !controleTechniqueSelect;
                      setState(() {});
                    }),
                    child: ContainerSelcted(
                      select: controleTechniqueSelect,
                      titre: "Controle technique",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() {
                      electriciteSelect = !electriciteSelect;
                      setState(() {});
                    }),
                    child: ContainerSelcted(
                      select: electriciteSelect,
                      titre: "Electricité",
                    ),
                  )
                ],
              )),
        ),
      ];
  int _activeStepIndex = 0;
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return !loading
        ? Scaffold(
            body: !transfertOk
                ? Form(
                    key: _formKey,
                    child: Stepper(
                      type: isDesktop
                          ? StepperType.vertical
                          : StepperType.horizontal,
                      currentStep: _activeStepIndex,
                      onStepTapped: (index) {
                        _activeStepIndex = index;
                        setState(() {});
                      },
                      onStepContinue: () {
                        if (_activeStepIndex <
                            (stepList(isDesktop).length - 1)) {
                          _activeStepIndex += 1;
                        }
                        setState(() {});
                      },
                      onStepCancel: () {
                        if (_activeStepIndex == 0) {
                          return;
                        }
                        _activeStepIndex -= 1;
                        setState(() {});
                      },
                      steps: stepList(isDesktop),
                      controlsBuilder:
                          (BuildContext context, ControlsDetails details) {
                        return Row(
                          children: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.white,
                                backgroundColor: details.stepIndex > 0
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              onPressed: details.onStepCancel,
                              child: const Text('Precedent'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            details.stepIndex <= 1
                                ? TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: details.onStepContinue,
                                    child: const Text('Suivant'),
                                  )
                                : const SizedBox(),
                            details.stepIndex > 1
                                ? TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      final FormState? formState =
                                          _formKey.currentState;
                                      formState!.save();
                                      final fileName = basename(_image.path);
                                      data.url = fileName;
                                      final destination = 'files/$fileName';
                                      //_image == File('') ? _image.path : _image.path;
                                      debugPrint(_image == File('')
                                          ? _image.path
                                          : _image.path);
                                      setState(() {
                                        loading = true;
                                      });

                                      await uploadFile(destination, _image.path)
                                          .whenComplete(
                                              () => debugPrint("complete"));
                                      String scanUrl = _image.path;
                                      Facture facture = Facture(
                                          factureid: " ",
                                          nom: data.nom,
                                          date: data.date,
                                          commentaire: data.commentaire,
                                          carid: data.carId,
                                          scanurl: data.url);
                                      await DataBase()
                                          .addFacture(widget.user, facture);
                                      setState(() {
                                        loading = false;
                                        transfertOk = true;
                                      });
                                    },
                                    child: const Text('Confirmer'),
                                  )
                                : const SizedBox(),
                          ],
                        );
                      },
                    ),
                  )
                : const ConfirmStatus(),
          )
        : const Loading(color: Colors.white);
  }
}

class ConfirmStatus extends StatelessWidget {
  const ConfirmStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(child: Text("Facture ajouté !")),
    );
  }
}

class ContainerSelcted extends StatelessWidget {
  const ContainerSelcted({
    Key? key,
    required this.select,
    required this.titre,
  }) : super(key: key);

  final bool select;
  final String titre;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: select ? Colors.blue : Colors.grey),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(titre),
            select ? const Icon(Icons.check) : const SizedBox()
          ],
        ));
  }
}

class SelectedContainer extends StatelessWidget {
  bool selected;
  SelectedContainer({
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: selected ? Colors.blue : Colors.grey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: const Text("Pneumatique"),
    );
  }
}
 */
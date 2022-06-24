import 'dart:io';
import 'dart:typed_data';

import 'package:bill/models/car.dart';
import 'package:bill/models/facture.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../commons/widgets/loading.dart';
import '../commons/widgets/responsive.dart';

class PhotoScreen extends StatefulWidget {
  final UserApp user;
  final Car? car;
  final Map cars;
  const PhotoScreen(
      {Key? key, required this.user, required this.cars, this.car})
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
  File _image = File('');
  final dynamic _firebaseStorage = firebase_storage.FirebaseStorage.instance;
  Uint8List webImage = Uint8List(10);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RevisionFacture detailRevision = RevisionFacture();
  PneumatiqueFacture pneumatiqueFacture = PneumatiqueFacture();
  FreinageFacture freinageFacture = FreinageFacture();
  ControleTechniqueFacture controleTechniqueFacture =
      ControleTechniqueFacture();
  ElectriciteFacture electriciteFacture = ElectriciteFacture();
  CourroieFacture courroieFacture = CourroieFacture();
  EmbrayageFacture embrayageFacture = EmbrayageFacture();
  AutreFacture autreFacture = AutreFacture();

  Future<void> showinformationDialogRevision(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Révision")),
                    const Text("Filtre :"),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.huileB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.huileB = !detailRevision.huileB!;
                              },
                            ),
                          },
                        ),
                        const Text("huile"),
                        Checkbox(
                          value: detailRevision.pollenB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.pollenB =
                                    !detailRevision.pollenB!;
                              },
                            ),
                          },
                        ),
                        const Text("pollen/habitacle"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.airB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.airB = !detailRevision.airB!;
                              },
                            ),
                          },
                        ),
                        const Text("air"),
                        Checkbox(
                          value: detailRevision.carburantB,
                          onChanged: (value) => {
                            setState(() {
                              detailRevision.carburantB =
                                  !detailRevision.carburantB!;
                            }),
                          },
                        ),
                        const Text("Carburant"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.freinB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.freinB = !detailRevision.freinB!;
                              },
                            ),
                          },
                        ),
                        const Text("liquide de frein"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.transmitionB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.transmitionB =
                                    !detailRevision.transmitionB!;
                              },
                            ),
                          },
                        ),
                        const Text("huilde de transmission"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.boitevitesseB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.boitevitesseB =
                                    !detailRevision.boitevitesseB!;
                              },
                            ),
                          },
                        ),
                        const Text("huilde de boîte de vitesse"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: detailRevision.refroidissementB,
                          onChanged: (value) => {
                            setState(
                              () {
                                detailRevision.refroidissementB =
                                    !detailRevision.refroidissementB!;
                              },
                            ),
                          },
                        ),
                        const Text("huilde de refroidisement"),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      detailRevision.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      detailRevision = RevisionFacture();
                      //detailRevision.selected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogPneumatique(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Pneumatique")),
                    Row(
                      children: [
                        Checkbox(
                          value: pneumatiqueFacture.avantB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.avantB =
                                    !pneumatiqueFacture.avantB!;
                              },
                            ),
                          },
                        ),
                        const Text("avant"),
                        Checkbox(
                          value: pneumatiqueFacture.arriereB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.arriereB =
                                    !pneumatiqueFacture.arriereB!;
                              },
                            ),
                          },
                        ),
                        const Text("arriere"),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("Marque des pneus :"),
                        Text("______________")
                        //TextFormField()
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Nombre :"),
                        Checkbox(
                          value: pneumatiqueFacture.twoB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.twoB =
                                    !pneumatiqueFacture.twoB!;
                              },
                            ),
                          },
                        ),
                        const Text("2"),
                        Checkbox(
                          value: pneumatiqueFacture.fourB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.fourB =
                                    !pneumatiqueFacture.fourB!;
                              },
                            ),
                          },
                        ),
                        const Text("4"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: pneumatiqueFacture.pneuHiverB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.pneuHiverB =
                                    !pneumatiqueFacture.pneuHiverB!;
                              },
                            ),
                          },
                        ),
                        const Text("Pneus hiver"),
                      ],
                    ),
                    Row(
                      children: const [
                        Text("Dimenssion : ______________"), //TextFormField()
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: pneumatiqueFacture.geometrieB,
                          onChanged: (value) => {
                            setState(
                              () {
                                pneumatiqueFacture.geometrieB =
                                    !pneumatiqueFacture.geometrieB!;
                              },
                            ),
                          },
                        ),
                        const Text("Géométrie"),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      pneumatiqueFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      pneumatiqueFacture = PneumatiqueFacture();
                      //detailRevision.selected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogFreingage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Freinage")),
                    Row(
                      children: [
                        Checkbox(
                          value: freinageFacture.avantB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.avantB =
                                    !freinageFacture.avantB!;
                              },
                            ),
                          },
                        ),
                        const Text("avant"),
                        Checkbox(
                          value: freinageFacture.arriereB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.arriereB =
                                    !freinageFacture.arriereB!;
                              },
                            ),
                          },
                        ),
                        const Text("arriere"),
                      ],
                    ),
                    const Text("Disque :"),
                    Row(
                      children: [
                        Checkbox(
                          value: freinageFacture.disqueAvantB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.disqueAvantB =
                                    !freinageFacture.disqueAvantB!;
                              },
                            ),
                          },
                        ),
                        const Text("Avant"),
                        Checkbox(
                          value: freinageFacture.disqueArriereB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.disqueArriereB =
                                    !freinageFacture.disqueArriereB!;
                              },
                            ),
                          },
                        ),
                        const Text("Arriere"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: freinageFacture.freinTambourB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.freinTambourB =
                                    !freinageFacture.freinTambourB!;
                              },
                            ),
                          },
                        ),
                        const Text("frein tambour"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: freinageFacture.purgeLiquideB,
                          onChanged: (value) => {
                            setState(
                              () {
                                freinageFacture.purgeLiquideB =
                                    !freinageFacture.purgeLiquideB!;
                              },
                            ),
                          },
                        ),
                        const Text("Purge de liquide de frein"),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      freinageFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      freinageFacture = FreinageFacture();
                      //detailRevision.selected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogControleTechnique(
      BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Controle technique")),
                    Row(
                      children: [
                        Checkbox(
                          value: controleTechniqueFacture.favorable,
                          onChanged: (value) => {
                            setState(
                              () {
                                controleTechniqueFacture.favorable =
                                    !controleTechniqueFacture.favorable!;
                                controleTechniqueFacture.contreVisite = false;
                              },
                            ),
                          },
                        ),
                        const Text("favorable"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: controleTechniqueFacture.contreVisite,
                          onChanged: (value) => {
                            setState(
                              () {
                                controleTechniqueFacture.contreVisite =
                                    !controleTechniqueFacture.contreVisite!;
                                controleTechniqueFacture.favorable = false;
                              },
                            ),
                          },
                        ),
                        const Text("Contre visite"),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      controleTechniqueFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      controleTechniqueFacture = ControleTechniqueFacture();
                      //detailRevision.selected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogElectricite(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Electricité")),
                    Row(
                      children: [
                        Checkbox(
                          value: electriciteFacture.alternateur,
                          onChanged: (value) => {
                            setState(
                              () {
                                electriciteFacture.alternateur =
                                    !electriciteFacture.alternateur!;
                              },
                            ),
                          },
                        ),
                        const Text("Alternateur"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: electriciteFacture.batterie,
                          onChanged: (value) => {
                            setState(
                              () {
                                electriciteFacture.batterie =
                                    !electriciteFacture.batterie!;
                              },
                            ),
                          },
                        ),
                        const Text("Batterie"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: electriciteFacture.demarreur,
                          onChanged: (value) => {
                            setState(
                              () {
                                electriciteFacture.demarreur =
                                    !electriciteFacture.demarreur!;
                              },
                            ),
                          },
                        ),
                        const Text("Demarreur"),
                      ],
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      electriciteFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      electriciteFacture = ElectriciteFacture();
                      //detailRevision.selected = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogCouroie(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Courroie")),
                    Row(
                      children: [
                        Checkbox(
                          value: courroieFacture.kitAccessoire,
                          onChanged: (value) => {
                            setState(
                              () {
                                courroieFacture.kitAccessoire =
                                    !courroieFacture.kitAccessoire!;
                              },
                            ),
                          },
                        ),
                        const Text("Kit accessoire"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: courroieFacture.kitDeDistribution,
                          onChanged: (value) => {
                            setState(
                              () {
                                courroieFacture.kitDeDistribution =
                                    !courroieFacture.kitDeDistribution!;
                              },
                            ),
                          },
                        ),
                        const Text("Kit de distribution"),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      courroieFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      courroieFacture = CourroieFacture();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogAutre(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Autre")),
                    const Text("Commentaire"),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          autreFacture.commentaire = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      autreFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      autreFacture = AutreFacture();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  Future<void> showinformationDialogEmbrayage(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(child: Text("Embrayage")),
                    Row(
                      children: [
                        Checkbox(
                          value: embrayageFacture.butee,
                          onChanged: (value) => {
                            setState(
                              () {
                                embrayageFacture.butee =
                                    !embrayageFacture.butee!;
                              },
                            ),
                          },
                        ),
                        const Text("Buttée"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: embrayageFacture.embrayage,
                          onChanged: (value) => {
                            setState(
                              () {
                                embrayageFacture.embrayage =
                                    !embrayageFacture.embrayage!;
                              },
                            ),
                          },
                        ),
                        const Text("Embrayage"),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: embrayageFacture.volantMoteur,
                          onChanged: (value) => {
                            setState(
                              () {
                                embrayageFacture.volantMoteur =
                                    !embrayageFacture.volantMoteur!;
                              },
                            ),
                          },
                        ),
                        const Text("Volant Moteur"),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    setState(() {
                      embrayageFacture.selected = true;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("valider"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Annuler"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      embrayageFacture = EmbrayageFacture();
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("supprimer"),
                )
              ],
            );
          },
        );
      },
    );
  }

  final picker = ImagePicker();
  bool loading = false;
  bool transfertOk = false;

  Future getImage(ImageSource source) async {
    // MOBILE
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: source);

      if (image != null) {
        var selected = File(image.path);

        setState(() {
          _image = selected;
        });
      } else {
        debugPrint("No file selected");
      }
    }
    // WEB
    else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _image = File("a");
          webImage = f;
        });
      } else {
        debugPrint("No file selected");
      }
    } else {
      debugPrint("Permission not granted");
    }
  }

  Future<void> uploadFile(String destination, String filePath) async {
    Reference _reference = _firebaseStorage.ref().child(destination);
    if (kIsWeb) {
      await _reference
          .putData(
        webImage,
        SettableMetadata(contentType: 'image/jpeg'),
      )
          .whenComplete(() async {
        await _reference.getDownloadURL().then((value) {
          debugPrint(value);
        });
      });
    } else if (!kIsWeb) {
      File file = File(filePath);
      await _reference.putFile(file);
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
            child: Column(
              children: [
                Container(
                  child: _image.path.isEmpty
                      ? const Text("Pas de facture sélectionné")
                      : kIsWeb
                          ? Text(basename(_image.toString()))
                          : Image.file(_image),
                ),
                kIsWeb
                    ? const SizedBox.shrink()
                    : TextButton.icon(
                        onPressed: () async {
                          await getImage(ImageSource.camera);

                          setState(() {
                            _image = File(_image.path);
                          });
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text("scanner une facture"),
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
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Information'),
          content: StreamBuilder<QuerySnapshot>(
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
                    errorFormatText: "La date n'est pas dans un format valide",
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Titre de la facture"),
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
                    decoration: const InputDecoration(labelText: "Département"),
                    onSaved: (value) => data.departement = value ?? "",
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Commentaire"),
                    onSaved: (value) => data.commentaire = value ?? "",
                  )
                ],
              );
            },
          ),
        ),
        Step(
          state: StepState.editing,
          isActive: _activeStepIndex >= 2,
          title: const Text('Details'),
          content: SizedBox(
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogRevision(
                        this.context,
                      ).then((value) {
                        setState(() {
                          detailRevision;
                        });
                      });
                      setState(() {
                        detailRevision.selected = detailRevision.selected;
                      });
                    }),
                    child: ContainerSelcted(
                      select: detailRevision.selected, //revisionSelect,
                      titre: "Révision",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogPneumatique(
                        this.context,
                      ).then((value) {
                        setState(() {
                          pneumatiqueFacture;
                        });
                      });
                      setState(() {
                        pneumatiqueFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: pneumatiqueFacture.selected,
                      titre: "Pneumatique",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogFreingage(this.context)
                          .then((value) {
                        setState(() {
                          freinageFacture;
                        });
                      });
                      setState(() {
                        freinageFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: freinageFacture.selected,
                      titre: "Freinage",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogControleTechnique(this.context)
                          .then((value) {
                        setState(() {
                          controleTechniqueFacture;
                        });
                      });
                      setState(() {
                        controleTechniqueFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: controleTechniqueFacture.selected,
                      titre: "Controle technique",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogElectricite(this.context)
                          .then((value) {
                        setState(() {
                          electriciteFacture;
                        });
                      });
                      setState(() {
                        electriciteFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: electriciteFacture.selected,
                      titre: "Electricité",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogCouroie(this.context)
                          .then((value) {
                        setState(() {
                          electriciteFacture;
                        });
                      });

                      setState(() {
                        electriciteFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: courroieFacture.selected,
                      titre: "Couroie",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogEmbrayage(this.context).then(
                        (value) {
                          setState(() {
                            embrayageFacture;
                          });
                        },
                      );
                      setState(() {
                        embrayageFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: embrayageFacture.selected,
                      titre: "Embrayage ",
                    ),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      await showinformationDialogAutre(this.context).then(
                        (value) {
                          setState(() {
                            autreFacture;
                          });
                        },
                      );
                      setState(() {
                        autreFacture;
                      });
                    }),
                    child: ContainerSelcted(
                      select: autreFacture.selected,
                      titre: "Autre",
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
                              child: const Text('Précédent'),
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
                                        () => debugPrint("complete"),
                                      );
                                      Facture facture = Facture(
                                          factureid: " ",
                                          nom: data.nom,
                                          date: data.date,
                                          commentaire: data.commentaire,
                                          carid: data.carId,
                                          scanurl: data.url);
                                      await DataBase().addFacture(
                                          widget.user,
                                          facture,
                                          detailRevision.selected
                                              ? detailRevision
                                              : null,
                                          pneumatiqueFacture.selected
                                              ? pneumatiqueFacture
                                              : null);
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
    return const Center(child: Text("Facture ajouté !"));
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
  final bool selected;
  const SelectedContainer({
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

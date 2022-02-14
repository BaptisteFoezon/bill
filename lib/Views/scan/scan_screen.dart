import 'dart:io';
import 'package:bill/Views/widgets/customDrawer.dart';
import 'package:bill/models/car.dart';
import 'package:bill/models/user_app.dart';
import 'package:bill/services/database.dart';
import 'package:bill/services/service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoScreen extends StatefulWidget {
  UserApp user;
  Car? car;
  Map cars;
  PhotoScreen({Key? key, required this.user, required this.cars, this.car})
      : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File _image = File("");

  final imagePicker = ImagePicker();

  Future getImage(ImageSource source) async {
    debugPrint("pick image ");
    final image = await imagePicker.pickImage(source: source);
    debugPrint("pick image ");
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  String dropdownValue = "Choisissez votre voiture";
  Car? carSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () => loggeOut(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      drawer: customDrawer(widget.user, context),
      body: Center(
        child: Column(
          children: [
            Form(
              child: Column(
                children: [],
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              items: <String>[
                "Choisissez votre voiture",
                "voiture 1",
                "voiture 2",
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                debugPrint("dropdown choice : " + newValue!);
                setState(() {
                  dropdownValue = newValue;
                });
                debugPrint(dropdownValue);
              },
            ),
            Container(
              child: _image.path.isEmpty
                  ? const Text("no image picked up")
                  : Image.file(_image),
            ),
            TextButton.icon(
              onPressed: () async => getImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text("scanner une facture"),
            ),
            TextButton.icon(
              onPressed: () async => getImage(ImageSource.gallery),
              icon: const Icon(Icons.file_download),
              label: const Text("importer depuis votre gallerie"),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bill/Models/car.dart';
import 'package:flutter/material.dart';

class Card extends StatelessWidget {
  Car _car;
  bool add;
  Card(this._car, this.add, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 900,
      width: 50,
      child: Column(
        children: [Text(_car.modele)],
      ),
    );
  }
}

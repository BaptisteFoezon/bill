import 'package:flutter/material.dart';

final textinputdecoration = InputDecoration(
  hintText: 'Mot de passe',
  hintStyle: const TextStyle(color: Colors.white),
  fillColor: Colors.black,
  filled: true,
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  ),
  contentPadding: const EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: const BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(14.0),
    borderSide: const BorderSide(color: Colors.blue, width: 1.0),
  ),
);

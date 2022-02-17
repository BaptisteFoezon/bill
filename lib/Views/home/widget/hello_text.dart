import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelloText extends StatelessWidget {
  String name;
  HelloText({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        "Bonjour , $name",
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

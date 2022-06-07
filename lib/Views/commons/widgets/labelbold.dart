import 'package:flutter/material.dart';

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

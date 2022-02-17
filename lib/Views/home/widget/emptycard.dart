import 'package:flutter/material.dart';

class CardEmpty extends StatelessWidget {
  double height;
  double width;
  CardEmpty({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

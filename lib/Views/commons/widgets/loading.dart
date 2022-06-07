import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final Color color;

  const Loading({Key? key, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Center(
        child: SpinKitRipple(
          color: Colors.blue,
          size: 80.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BrnProgIndicato extends StatelessWidget {

  final double size;
  final Color color;

  BrnProgIndicato(
      { this.size: 24, this.color: Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(color),
        ));
  }
}

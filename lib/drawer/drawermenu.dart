import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Colors.brown,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.brown,
        Colors.white,
      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
    );
  }
}

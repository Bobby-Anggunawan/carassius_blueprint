import 'dart:async';

import "package:flutter/material.dart";
import 'package:carassius_blueprint/carassius_blueprint.dart';


class Halaman3 extends StatelessWidget {
  Halaman3({Key? key}) : super(key: key);

  final LayoutVariationController myController = LayoutVariationController();

  final KoiFullscreenDialog aDialog = KoiFullscreenDialog(
    content: Container(
      color: Colors.green,
      child: Center(
        child: Text("Ikan"),
      ),
    ),
    title: 'Ayam',
    onConfirm: (){},
  );

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            aDialog.show(context);
          },
          child: Text("click me"),

        ),
      ),
    );
  }
}

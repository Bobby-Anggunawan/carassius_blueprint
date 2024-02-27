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


    var myProgress = KoiProgressIndicator.showBassedFromHistory(historyKey: "sapi");

    Future.delayed(const Duration(seconds: 30), () {
      myProgress.recordHistoryOfKey();
    });


    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.lightGreenAccent,
          width: 100,
          height: 100,
          child: myProgress,
        ),
      ),
    );
  }
}

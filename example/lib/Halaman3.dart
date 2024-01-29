import 'dart:async';

import "package:flutter/material.dart";
import 'package:carassius_blueprint/carassius_blueprint.dart';


class Halaman3 extends StatelessWidget {
  Halaman3({Key? key}) : super(key: key);

  final LayoutVariationController myController = LayoutVariationController();

  @override
  Widget build(BuildContext context) {

    //----------
    Timer.periodic(
      Duration(seconds: 1),
        (timer){
          myController.setLayout("satu");
        }
    );
    //----------

    //----------
    Timer.periodic(
        Duration(seconds: 1),
            (timer){
          myController.setLayout("dua");
        }
    );
    //----------

    //----------
    Timer.periodic(
        Duration(seconds: 1),
            (timer){
          myController.setLayout("tiga");
        }
    );
    //----------

    //----------
    Timer.periodic(
        Duration(seconds: 1),
            (timer){
          myController.setLayout("empat");
        }
    );
    //----------

    return Scaffold(
      body: KoiLayoutVariation(
        controller: myController,
        layoutList: {
          "satu": Container(color: Colors.red, child: Center(child: Text("Satu"),),),
          "dua": Container(color: Colors.blue, child: Center(child: Text("Dua"),),),
          "tiga": Container(color: Colors.green, child: Center(child: Text("Tiga"),),),
          "empat": Container(color: Colors.yellow, child: Center(child: Text("Empat"),),),
        },
      ),
    );
  }
}

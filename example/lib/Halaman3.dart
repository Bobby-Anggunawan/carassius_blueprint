import 'dart:async';

import "package:flutter/material.dart";
import 'package:carassius_blueprint/carassius_blueprint.dart';


class Halaman3 extends StatelessWidget {
  Halaman3({Key? key}) : super(key: key);

  final LayoutVariationController myController = LayoutVariationController();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: KoiLayoutResponsive(updateWhenResize: true,)
          .setPhone(Center(child: Text("Phone"),))
          .setTablet(Center(child: Text("Tablet"),))
          .setLaptop(Center(child: Text("Laptop"),))
          .setDesktop(Center(child: Text("Desktop"),))
      ,
    );
  }
}

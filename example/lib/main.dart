import 'package:example/Halaman1.dart';
import 'package:example/Halaman2.dart';
import 'package:flutter/material.dart';
//import 'package:carassius_blueprint/extension/carassius_extension.dart';
import 'package:carassius_blueprint/carassius_blueprint.dart';

void main() {
  runApp(
      KoiScaffold(
        themeColor: ThemeColor.autoGenerateFromColor(Colors.deepOrange),
        routes: KoiScaffoldRoute
            .baseRoute(Halaman1())
            .addRoutes("/halaman2", Halaman2())
      )
  );
}
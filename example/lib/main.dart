import 'package:example/Halaman1.dart';
import 'package:example/Halaman2.dart';
import 'package:flutter/material.dart';
//import 'package:carassius_blueprint/extension/carassius_extension.dart';
import 'package:carassius_blueprint/carassius_blueprint.dart';

import 'HalamanResponsive.dart';

void main() {
  runApp(
      KoiScaffold(
        themeColor: ThemeColor.autoGenerateFromColor(Colors.deepOrange),
        routes: KoiScaffoldRoute
            //.baseRoute(Scaffold(body: HalamanResponsive(),))
            //.baseRoute(KoiPageError.Forbidden(message: "Ini test",))
            .baseRoute(Halaman1())
            .addRoutes("/halaman2", Halaman2())
            .addRoutes("/halaman3", Scaffold(
              appBar: AppBar(title: Text("Halaman 3"),),
              body: Center(
                child: Text("Ini halaman ketiga"),
              ),
            ))
      )
  );
}
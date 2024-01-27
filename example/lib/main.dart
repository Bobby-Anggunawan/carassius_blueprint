import 'package:carassius_blueprint/pages/KoiPageSplash.dart';
import 'package:example/Halaman1.dart';
import 'package:example/Halaman2.dart';
import 'package:example/Halaman3.dart';
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
            .baseRoute(KoiPageSplash(redirectTo: "/testWidget", redirectAfter: 3, initialization: (context)async{

              print("Start wait at ${DateTime.now()}");
              await Future.delayed(Duration(seconds: 5));
              print("End wait at ${DateTime.now()}");

              var result = await KoiHttp.basicRequest("https://api.coindesk.com/v1/bpi/currentprice.json", null, RequestMethod.GET, null, null);

              print(result["disclaimer"]);
            },))
            //.baseRoute(Halaman1())
            .addRoutes("/halaman2", Halaman2())
            .addRoutes("/halaman3", Halaman3())
            .addRoutes(
              '/testWidget',
              KoiPageForm(
                title: 'Judul form',
                field: {
                  "teks1": FieldType.text,
                  "teks2": FieldType.text,
                  "pass": FieldType.password
                },
                background: Container(
                  color: Colors.blue,
                ),
                onSubmit: (Map<String, dynamic> value) {
                  print("teks1: ${value}");
                  print("teks2: ${value["teks2"] ?? "masih null"}");
                  print("pass: ${value["pass"] ?? "masih null"}");
                },
                  submitButton: (submitFunc){
                    return ElevatedButton(onPressed: (){
                      submitFunc();
                    }, child: Text("Ikan"));
                  }
              )
            )
      )
  );
}
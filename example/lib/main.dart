import 'package:flutter/material.dart';
//import 'package:carassius_blueprint/extension/carassius_extension.dart';
import 'package:carassius_blueprint/carassius_blueprint.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  String nilaiTampil = "Loading..";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    KoiHttp.basicRequest("https://api.coindesk.com/v1/bpi/currentprice.json", null, RequestMethod.GET, null, null).then((value){
      setState(() {
        print("reload");
        nilaiTampil = value["time"]["updated"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Example"),
        ),
        body: Center(
          child: Text(nilaiTampil),
        ),
      ),
    );
  }
}
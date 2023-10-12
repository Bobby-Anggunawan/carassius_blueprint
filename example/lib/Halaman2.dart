import "dart:ui";

import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

class Halaman2 extends StatelessWidget {
  const Halaman2({Key? key}) : super(key: key);

  bool isWithinRange(double value, double min, double max){
    if(value>=min && value<=max){
      return true;
    }
    else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;

    double screedWidth = size.width;

    return Scaffold(
      appBar: AppBar(title: Text("Halaman 2"),),
      body: Container(
        child: Container(
          width: 100,
          color: Colors.blue,
          child: ListView(
            children: [

              KoiLayoutResponsive()
                  .setPhone(Text("Phone"))
                .setTablet(Text("TRablet"))
            .setLaptop(Text("laptop"))
        .setDesktop(Text("desktop")),


              Text(isWithinRange(197, 1, 10).toString()),

              Text(context.koiSpacing.autoBeetweenPane().toString()),
              Text(context.koiSpacing.largest.toString()),

              ElevatedButton(
                child: Text("${context.koiBreakpoint.name}"),
                onPressed: (){
                  Navigator.of(context).pushNamed("/");
                },
              ),

              ElevatedButton(
                child: Text("${screedWidth}"),
                onPressed: (){
                  Navigator.of(context).pushNamed("/");
                },
              ),

              ElevatedButton(
                child: Text("Star loading"),
                onPressed: (){
                  KoiScaffold.isLoading = true;
                },
              ),
              ElevatedButton(
                child: Text("End loading"),
                onPressed: (){
                  KoiScaffold.isLoading = false;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

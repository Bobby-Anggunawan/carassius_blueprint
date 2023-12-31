import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

class Halaman1 extends StatelessWidget {
  const Halaman1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman 1"),),
      body: ListView(
        children: [

          KoiContainer.card(child: Text("IKAN ASIN")),

          Text("ikan asin", style: context.koiThemeText.display().copyWith(color: context.koiThemeColor.error),),

          KoiContainer(
            type: MaterialType.card,
              elevation: 5,
              color: Colors.blue,
              height: 200,
              ratio: Ratio.PortraitShort(),
              child: Container()
          ),

          ElevatedButton(
            child: Text("Ke halaman 2"),
            onPressed: (){
              Navigator.of(context).pushNamed("/halaman2");
            },
          )
        ],
      ),
    );
  }
}

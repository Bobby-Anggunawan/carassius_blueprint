import "package:flutter/material.dart";

/// gunakan fungsi [setLayout()] untuk mengganti layout
class LayoutVariationController{
  LayoutVariationController(): _showedLayoutKey = ValueNotifier(null);
  LayoutVariationController.initialKey(String showedLayoutKey): _showedLayoutKey = ValueNotifier(showedLayoutKey);

  /// key layout yang saat ini ditampilkan
  ValueNotifier<String?> _showedLayoutKey;

  /// ubah layout yang ditampilkan
  void setLayout(String key){
    _showedLayoutKey.value = key;
  }
}

/// halaman untuk menampilkan beberapa widget sesuai key
///
/// masukkan layout ke [layoutList] beserta keynya
///
/// gunakan [controller.setLayout(key)] untuk mengatur layout mana yang saat ini ditampilkan dengan memasukkan key yang di set di [layoutList]
class KoiLayoutVariation extends StatefulWidget {

  KoiLayoutVariation({Key? key, required this.layoutList, required this.controller}): super(key: key);


  /// daftar layout yang bisa ditampilkan beserta key untuk mengaksesnya
  ///
  /// gunakan [controller] untuk mengatur layout mana yang saat ini ditampilkan
  final Map<String, Widget> layoutList;
  /// untuk mengatur layout yang ditampilkan dari map [layoutList]
  ///
  /// gunakan [controller.setLayout(key)] untuk mengatur layout mana yang saat ini ditampilkan dengan memasukkan key yang di set di [layoutList]
  final LayoutVariationController controller;

  @override
  State<KoiLayoutVariation> createState() => _KoiLayoutVariationState();
}

class _KoiLayoutVariationState extends State<KoiLayoutVariation> {
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder(
      valueListenable: widget.controller._showedLayoutKey,
      builder: (BuildContext context, value, Widget? child) {

        var widgetToRet = widget.layoutList[
          widget.controller._showedLayoutKey.value ?? widget.layoutList.keys.first
        ];

        if(widgetToRet != null){
          return widgetToRet;
        }
        else{
          throw AssertionError("KoiLayoutVariation: Error, layout dengan key '${widget.controller._showedLayoutKey.value}' tersebut tidak ditemukan");
        }
      },
    );
  }
}



/*
* CONTOH PENGGUNAAN
*
* class Halaman3 extends StatelessWidget {
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
}*/
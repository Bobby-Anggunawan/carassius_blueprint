import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

class KoiLayoutVariation extends StatelessWidget {

  const KoiLayoutVariation({Key? key, this.daftarLayout = const {}, this.showedLayoutKey = const {"showedLayoutKey": null}}): super(key: key);


  final Map<String, Widget> daftarLayout;
  final Map<String, String?> showedLayoutKey;

  /// Tambah variasi halaman baru dan key untuk mengakses variasi halaman ini di fungsi [showLayoutWithKey()].
  ///
  /// **Parameter**
  /// * [key]: Parameter yang digunakan untuk mengakses layout ini
  /// * [layout]: Layout yang akan ditampilkan
  ///
  /// **Contoh**
  /// * KoiLayoutVariation.addLayout(key: "halaman1", layout: Halaman1())
  ///
  /// **WARNING**
  /// * Kalau [addLayout()] digunakan untuk menambah layout baru dengan key yang sudah ada, fungsi ini akan mereturn error
  KoiLayoutVariation addLayout({required String key, required Widget layout}){

    if(daftarLayout[key] != null){
      throw AssertionError("Key dari layout ini sudah ada. Gunakan key lain..");
    }

    daftarLayout[key] = layout;
    return this;
  }


  /// Key layout yang akan ditampilkan. Layout dan keynya di set di fungsi [addLayout()]
  ///
  /// **Parameter**
  /// * [key]: Key dari layout yang akan tampil
  ///
  /// **Contoh**
  /// * KoiLayoutVariation.showLayoutWithKey(key: "halaman1")
  ///
  /// **WARNING**
  /// * Kalau key di sini tidak ditemukan(tidak pernah ditambahkan dengan [addLayout()]), widget ini akan menghasilkan error
  KoiLayoutVariation showLayoutWithKey({required String key}){
    showedLayoutKey["showedLayoutKey"] = key;
    return this;
  }


  @override
  Widget build(BuildContext context) {

    var aKey = showedLayoutKey["showedLayoutKey"];

    if(aKey != null){

      var widgetToRet = daftarLayout[aKey];

      if(widgetToRet != null){
        return widgetToRet;
      }
      else{
        throw AssertionError("KoiLayoutVariation: Error, layout dengan key tersebut tidak ditemukan");
      }
    }

    else{
      return KoiPageError.NotFound();
    }
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

/// berbagai fungsi fungsi/getter yang mungkin berguna
class KoiToolbox{

  /// lebar dan tinggi window/layar tempat aplikasi ini berada dalam satuan dp.
  ///
  /// > Sebenarnya sama dengan **[MediaQuery.of(context).size.width]**, hanya saja yang ini tidak perlu context.
  ///
  /// **Sumber**
  ///
  /// *https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width*
  static Size get windowSize{
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;

    return size;
  }

  /// generate warna dari string hex. Flutter tidak menyediakan cara default untuk buat warna dari hex
  ///
  /// **Parameter**
  /// * [hexValue] : hex value dari warna yang dibuat. misalnya "B74093" atau "b74093", capital atau tidak tidak masalah
  static Color colorFromHex(String hexValue){
    // note "FF" disini adalah opacity. opacity nya dibuat maksimal, tidak transparan
    var hexInt = int.parse("FF${hexValue.toUpperCase()}", radix: 16);

    return Color(hexInt);
  }

}
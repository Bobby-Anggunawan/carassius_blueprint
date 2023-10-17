import 'dart:ui';
import 'package:flutter/material.dart';

/// class yang digunakan untuk menyimpan nilai variable yang dipakai di library ini. Dapat juga digunakan aplikasi lain
class KoiVariable{

  /// lebar window/layar tempat aplikasi ini berada dalam satuan dp.
  ///
  /// > Sebenarnya sama dengan **[MediaQuery.of(context).size.width]**, hanya saja yang ini tidak perlu context.
  ///
  /// **Sumber**
  ///
  /// *https://stackoverflow.com/questions/49553402/how-to-determine-screen-height-and-width*
  static double get windowWidthDP{
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    Size size = view.physicalSize / view.devicePixelRatio;

    return size.width;
  }
}
import 'package:flutter/material.dart';

extension KoiFromColor on Color{
  /// berguna untuk mendapat skema warna yang sedang digunakan aplikasi yang di set di widget [MaterialApp]
  ColorScheme koiGetThemeColor(BuildContext context){
    return Theme.of(context).colorScheme;
  }
}
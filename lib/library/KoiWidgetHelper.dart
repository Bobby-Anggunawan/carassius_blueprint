import 'package:flutter/material.dart';

/// kumpulan fungsi yang berguna untuk membatu pemrosesan data dari widget-widget yang sudah disediakan default oleh flutter
class KoiWidgetHelper{

  /// kumpulan fungsi untuk widget [Text()]
  static TextHelper Text = TextHelper();
}

/// kumpulan fungsi untuk widget [Text()]
class TextHelper{
  /// Untuk menghitung size(tinggi dan lebar) text dari widget Text()
  Size getSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
import 'package:flutter/material.dart';

class KoiGetter{

  static ColorScheme themeColor(BuildContext context){
    return Theme.of(context).colorScheme;
  }

  static TextStyles themeText(BuildContext context){
    return TextStyles(context: context);
  }

}

class TextStyles{

  final BuildContext context;
  TextStyles({required this.context});

  /// untuk mendapat semua text style dari theme ini
  TextTheme getAllStyle(){
    return Theme.of(context).textTheme;
  }

  //======================================
  //daftar shortcut

  /// textstyle body dari theme ini
  TextStyle body({TextStyleSize size = TextStyleSize.Medium}){
    if(size == TextStyleSize.Small){
      return Theme.of(context).textTheme.bodySmall ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.bodyMedium ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.bodyLarge ?? TextStyle();
    }
    else{
      throw AssertionError("KoiFromTextStyle Error");
    }
  }

  /// textstyle title dari theme ini
  TextStyle title({TextStyleSize size = TextStyleSize.Medium}){
    if(size == TextStyleSize.Small){
      return Theme.of(context).textTheme.titleSmall ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.titleMedium ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.titleLarge ?? TextStyle();
    }
    else{
      throw AssertionError("KoiFromTextStyle Error");
    }
  }

  /// textstyle headline dari theme ini
  TextStyle headline({TextStyleSize size = TextStyleSize.Medium}){
    if(size == TextStyleSize.Small){
      return Theme.of(context).textTheme.headlineSmall ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.headlineMedium ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.headlineLarge ?? TextStyle();
    }
    else{
      throw AssertionError("KoiFromTextStyle Error");
    }
  }

  /// textstyle display dari theme ini
  TextStyle display({TextStyleSize size = TextStyleSize.Medium}){
    if(size == TextStyleSize.Small){
      return Theme.of(context).textTheme.displaySmall ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.displayMedium ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.displayLarge ?? TextStyle();
    }
    else{
      throw AssertionError("KoiFromTextStyle Error");
    }
  }

  /// textstyle label dari theme ini
  TextStyle label({TextStyleSize size = TextStyleSize.Medium}){
    if(size == TextStyleSize.Small){
      return Theme.of(context).textTheme.labelSmall ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.labelMedium ?? TextStyle();
    }
    else if(size == TextStyleSize.Medium){
      return Theme.of(context).textTheme.labelLarge ?? TextStyle();
    }
    else{
      throw AssertionError("KoiFromTextStyle Error");
    }
  }
}

enum TextStyleSize{
  Small,
  Medium,
  Large
}
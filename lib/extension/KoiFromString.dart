extension KoiFromString on String{

  /// Kalau misalnya isi string "IkanAsinGoreng", fungsi ini akan mereturn "Ikan Asin Goreng"
  String get koiAddSpaceBetweenEachCapital{

    String value = this;

    String ret = "";
    value.split('').forEach((ch){
      if(ch == ch.toUpperCase()){
        ret = ret+" ";
      }
      ret = ret+ch;
    });

    return ret;
  }

  /// apa string ini mengandung character lain selain whitespace (spaces, tabs atau line breaks)
  bool get koiIsOnlyWhitespace{
    if(this.trim().isEmpty){
      return true;
    }
    else{
      return false;
    }
  }
}
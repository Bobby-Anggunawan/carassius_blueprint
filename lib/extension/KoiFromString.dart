extension KoiFromString on String{

  /// Kalau misalnya isi string "IkanAsinGoreng", fungsi ini akan mereturn "Ikan Asin Goreng"
  String koiAddSpaceBetweenEachCapital(){

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
}
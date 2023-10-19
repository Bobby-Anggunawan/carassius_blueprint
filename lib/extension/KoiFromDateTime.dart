import 'package:carassius_blueprint/carassius_blueprint.dart';

extension KoiFromDateTime on DateTime{

  static Map<int, String> monthNames = {
    1 : "January",
    2 : "February",
    3 : "March",
    4 : "April",
    5 : "May",
    6 : "June",
    7 : "July",
    8 : "August",
    9 : "September",
    10 : "October",
    11 : "November",
    12 : "December"
  };

  /// hanya menampilkan jam saja dari [Datetime] ini.
  ///
  /// **Parameter**
  /// * separator : yang digunakan memisahkan jam, menit, dan detik. Misalnya nilainya ":", maka result fungsi ini akan seperti "18:00"
  /// * showSecond : jika false, detik tidak akan ditampilkan, hanya jam dan menit saja
  ///
  /// **Return**
  ///
  /// Dengan parameter default, returnnya akan seperti **08:00**, karena showSecond == false. Note, jika angka kurang dari 10, 0 akan otomatis ditambah di belakang jadi nilainya selalu 2 digit
  String koiStringOnlyTime({String separator = ":", bool showSecond = false}){
    if(showSecond){
      return "${this.hour.koiToXDigit}${separator}${this.minute.koiToXDigit}${separator}${this.second.koiToXDigit}";
    }
    else{
      return "${this.hour.koiToXDigit}${separator}${this.minute.koiToXDigit}";
    }
  }

  /// hanya menampilkan tanggal saja dari [Datetime] ini.
  ///
  /// **Parameter**
  /// * separator : yang digunakan memisahkan tanggal, bulan, dan tahun. Misalnya nilainya "-", maka result fungsi ini akan seperti "01-01-2000"
  /// * withYear : jika false, tahun tidak akan ditampilkan, hanya tanggal dan bulan saja
  ///
  /// **Return**
  ///
  /// Dengan parameter default, returnnya akan seperti **21 April 2000**. Note, jika angka kurang dari 10, 0 akan otomatis ditambah di belakang jadi nilainya selalu 2 digit
  String koiStringOnlyDate({String separator = " ", bool withYear = true, bool showMonthName = true}){
    late String month;
    if(showMonthName){
      month = monthNames[DateTime.now().month]!;
    }
    else{
      month = DateTime.now().month.koiToXDigit();
    }

    if(withYear){
      return "${this.day.koiToXDigit()}${separator}${month}${separator}${this.year}";
    }
    else{
      return "${this.day.koiToXDigit()}${separator}${month}";
    }
  }
}
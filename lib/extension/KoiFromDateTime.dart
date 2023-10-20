import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:flutter/material.dart';

extension KoiFromDateTime on DateTime{

  // todo, masukkan ke lokalisasi
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
      return "${this.hour.koiToXDigit()}${separator}${this.minute.koiToXDigit()}${separator}${this.second.koiToXDigit()}";
    }
    else{
      return "${this.hour.koiToXDigit()}${separator}${this.minute.koiToXDigit()}";
    }
  }

  /// hanya menampilkan tanggal saja dari [Datetime] ini. Formatnya **Tanggal** **Bulan** **Tahun**.
  ///
  /// **Parameter**
  /// * separator : yang digunakan memisahkan tanggal, bulan, dan tahun. Misalnya nilainya "-", maka result fungsi ini akan seperti "01-01-2000"
  /// * withYear : jika false, tahun tidak akan ditampilkan, hanya tanggal dan bulan saja
  /// * showMonthName : kalau true, maka 1 akan diganti jadi "January", dll
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

  /// Digunakan untuk mereturn selisih time pertama dan kedua.
  /// > Misalnya hasil returnnya bisa jadi **5 menit**, **2 jam**, atau **3 detik** tergantung besar perbedaannya
  ///
  /// **Parameter**
  /// * [dateTo] adalah datetime yang dibandingkan dengan datetime ini. Note, jika nilainya null, fungsi ini juga akan mengembalikan null
  /// * [leadingNegative] adalah string yang ditampilkan di awal result jika [dateTo] lebih kecil dari [Datetime] ini.
  /// * [leadingPositive] adalah string yang ditampilkan di awal result jika [dateTo] lebih besar dari [Datetime] ini.
  /// * [trailingNegative] adalah string yang ditampilkan di akhir result jika [dateTo] lebih kecil dari [Datetime] ini.
  /// * [trailingPositive] adalah string yang ditampilkan di akhir result jika [dateTo] lebih besar dari [Datetime] ini.
  ///
  /// **Note**
  /// > jika parameter [dateTo] bernilai null, fungsi ini akan mengembalikan null
  String? koiStringDifference(
    {
      required DateTime? to,
      String leadingNegative = "",
      String leadingPositive = "In",
      String trailingNegative = "Ago",
      String trailingPositive = ""
    }
  ){
    ShowWhenNegativeOrPositive leading = ShowWhenNegativeOrPositive(ifNegative: leadingNegative, ifPositive: leadingPositive);
    ShowWhenNegativeOrPositive trailing = ShowWhenNegativeOrPositive(ifNegative: trailingNegative, ifPositive: trailingPositive);

    if(to == null){
      return null;
    }
    else{
      var selisih = this.difference(to);
      if(selisih.inHours.abs() > 24){
        return leading.getResult(selisih.inDays, false)+"${selisih.inDays.abs()} Hari"+trailing.getResult(selisih.inDays, true);
      }
      else if(selisih.inMinutes.abs() > 60){
        return leading.getResult(selisih.inHours, false)+"${selisih.inHours.abs()} Hour"+trailing.getResult(selisih.inHours, true);
      }
      else if(selisih.inSeconds.abs() > 60){
        return leading.getResult(selisih.inMinutes, false)+"${selisih.inMinutes.abs()} Menit"+trailing.getResult(selisih.inMinutes, true);
      }
      else{
        return leading.getResult(selisih.inSeconds, false)+"${selisih.inSeconds.abs()} Detik"+trailing.getResult(selisih.inSeconds, true);
      }
    }

  }

  /// menampilkan datetime dalam format string
  ///
  /// > return seperti **Tomorrow, 19:00**, **Yesterday, 08:00**, **01:36**(jika hari yang sama)
  String koiStringDisplay({bool showSecond = false, String timeSeperator = ":", String yearSeperator = " ", bool showMonthName = true}){
    String? trailFrom;
    var nowTime = DateTime.now();

    // trailFrom cuma diisi kalau tidak hari ini
    if(nowTime.day != this.day || nowTime.month != this.month || nowTime.year != this.year){
      var testBesok = nowTime.add(Duration(days: 1));
      var testKemarin = nowTime.subtract(Duration(days: 1));
      if(testBesok.year == this.year && testBesok.month == this.month && testBesok.day == this.day){
        trailFrom = "Tomorrow";
      }
      else if(testKemarin.year == this.year && testKemarin.month == this.month && testKemarin.day == this.day){
        trailFrom = "Yesterday";
      }
      else if(this.year == nowTime.year){
        trailFrom = this.koiStringOnlyDate(withYear: false, separator: yearSeperator, showMonthName: showMonthName);
      }
      else{
        trailFrom = this.koiStringOnlyDate(withYear: true, separator: yearSeperator, showMonthName: showMonthName);
      }

      trailFrom = trailFrom+", ";
    }

    ///========================

    return "${trailFrom ?? ""}${this.koiStringOnlyTime(separator: timeSeperator, showSecond: showSecond)}";
  }

  String? koiStringTimespan(
      {
        required DateTime? to,
        String seperator = "until",
      }
  ){

    if(seperator != " "){
      seperator = " ${seperator.trim()} ";
    }

    if(to == null){
      return null;
    }
    else{
      return this.koiStringDisplay()+seperator+to.koiStringDisplay();
    }
  }

}


class ShowWhenNegativeOrPositive{
  late String ifNegative;
  late String ifPositive;

  String getResult(int value, bool isTrailing){

    if(value.isNegative){
      if(isTrailing){
        if(ifNegative.koiIsOnlyWhitespace){
          return "";
        }
        else{
          return " "+ifNegative.trim();
        }
      }
      else{
        if(ifNegative.koiIsOnlyWhitespace){
          return "";
        }
        else{
          return ifNegative.trim()+" ";
        }
      }
    }
    else{
      if(isTrailing){
        if(ifPositive.koiIsOnlyWhitespace){
          return "";
        }
        else{
          return " "+ifPositive.trim();
        }
      }
      else{
        if(ifPositive.koiIsOnlyWhitespace){
          return "";
        }
        else{
          return ifPositive.trim()+" ";
        }
      }
    }
  }

  ShowWhenNegativeOrPositive({required this.ifNegative, required this.ifPositive});
}
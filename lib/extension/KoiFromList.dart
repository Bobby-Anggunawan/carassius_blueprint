import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:flutter/cupertino.dart';

extension KoiFromList<T> on List<T>{

  /// akan menghasilkan file json dari list ini.
  ///
  /// **Parameter**
  /// * [keyName]: Nilai default null. Kalau diisi akan menghasilkan json seperti "{keyName: |values|}". Kalau tidak diisi jsonnya hanya "|values|"
  String koiToJsonString({String? keyName = null}){

    String listString = "";

    if(this.isNotEmpty){
      this.forEach((element) {

        String itemToAdd = "";

        // aturan bagaimana tiap item dimasukkan ke json
        if(element is int){
          itemToAdd = element.toString();
        }
        else if(element is String){
          itemToAdd = '"${element}"';
        }
        else if(element is bool){
          if(element == true){
            itemToAdd = "true";
          }
          else{
            itemToAdd = "false";
          }
        }
        else if(element == null){
          itemToAdd = "null";
        }
        else{
          itemToAdd = '"${element.toString()}"';
        }

        //=====================

        // masukkan item ke list
        if(listString == ""){
          listString += itemToAdd;
        }
        else{
          listString += ", ${itemToAdd}";
        }
      });
    }


    if(keyName == null){
      return "[${listString}]";
    }
    else{
      return '{"${keyName}": [${listString}]}';
    }
  }


  /// gabungkan list ini dengan list di parameternya
  ///
  /// **Parameter**
  /// * [otherList]: list yang mau digabungkan dengan list ini
  ///
  /// **Contoh**
  /// > |1, 2, 3|.koiJoinList(|4, 5, 6|)
  List<T> koiJoinList(List<T> otherList){
    var thisList = this as List<T>;

    if(thisList.length > 0 && otherList.length > 0){
      otherList.forEach((element) {
        thisList.add(element);
      });
    }

    return thisList;
  }


  /// remove semua nilai null dari list ini. Berguna di widget seperti [Row] dan [Column].
  /// > Misalnya ada widget yang hanya ditampilkan jika tidak null, biasanya di tiap widget harus di wrap dengan widget [Builder] dan di cek apa null atau tidak. Kalau null tampilkan widget [Container] atau [SizedBox]. Dengan getter ini, tidak perlu lagi menulis builder, tinggal masukkan saja ke dalam colomn
  ///
  /// **Contoh**
  ///
  /// *Row(children: |Text(), null, Text()|.koiRemoveNull())*
  List<U> koiRemoveNull<U>(){
    List<U> toReturn = [];
    this.forEach((element) {
      if(element != null){
        toReturn.add(element as U);
      }
    });

    return toReturn;
  }

  /// menambah element ini ke list ini jika isi list kosong.
  /// > misalnya di listview, bisa pakai fungsi ini untuk menampilkan test "data kosong" jika isi list sedang kosong
  ///
  /// **Parameter**
  /// * [elementIfEmpty] : element yang akan ditambah ke list ini jika data kosong
  ///
  /// **Ketentuan**
  /// * jika list kosong: akan mengembalikan list baru dengan isi 1 item dari parameter [elementIfEmpty]
  /// * jika list tidak kosong: akan mengembalikan list aslinya
  List<T> koiAddIfEmpty(T elementIfEmpty){
    if(this.isEmpty){
      return [elementIfEmpty];
    }
    return this;
  }

  /// menambah item diantara element dalam list ini. Sama dengan [KoiFromListWidget.koiAddSpacing()] bedanya ini tidak hanya untuk list widget saja
  /// > tips.. Spacing default listview = 8
  ///
  /// **Parameter**
  /// * [elementToAdd]: item yang ingin disisipkan di tiap element dalam list ini
  ///
  /// **Contoh**
  /// >> misalnya list alist = |"1", "2", "3"|
  ///
  /// *alist.koiAddBetweenElement(",")*
  ///
  /// > returnnya |"1", ",", "2", ",", "3"|
  List<T> koiAddBetweenElement(T elementToAdd){
    //start-tambah spacing
    List<T> ret = [];
    this.forEach((element) {
      ret.add(element);
      ret.add(elementToAdd);
    });

    //hapus sizebox terakhir
    ret.removeLast();
    //end---tambah spacing

    return ret;
  }
}
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
}
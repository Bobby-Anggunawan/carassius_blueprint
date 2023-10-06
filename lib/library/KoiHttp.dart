import 'dart:convert';

import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;


/// Untuk melakukan request ke server dan menerima result hanya dengan 1 baris kode
///
/// **Cara Penggunaan:**
/// >Untuk menggunakan nilai dari hasil request fungsi ini, akses sebagai map, misalnya:
///
/// >var result = CarassiusNetwork.baseRequest();
///
/// >result|"data"||0||"nama"|
class KoiHttp{

  /// Melakukan request dan mengembalikan result sebagai class dynamic (sudah diconvert dengan fungsi jsonDecode()).
  ///
  /// > Class ini belum bisa mengirim file ke server
  /// 
  /// **Note:**
  ///
  /// > Untuk menggunakan nilai dari hasil request fungsi ini, akses sebagai map, misalnya:
  ///
  /// > var result = CarassiusNetwork.baseRequest();
  ///
  /// > result|"data"||0||"nama"|
  ///
  /// **Parameter**
  /// * url: url yang digunakan untuk request misalnya https://example.com/api/test
  /// * uriParam: untuk memasukkan parameter ke uri request ini. Misalnya https://example.com/api/test?name=Clara?age=7. Gunakan fungsi BaseRequestUriParam().addKey() untuk menambah key
  /// * method: metode request yang ingin digunakan (get, post, put, dll)
  /// * header: isi header dari request ini. Gunakan fungsi BaseRequestHeader().addKey() untuk menambah key ke header ini
  /// * body: isi body dari request ini(dengan tipe form). Gunakan fungsi BaseRequestBody().addKey() untuk menambah key ke body ini
  /// * bodyRaw<optional>: kalau isi body bukan form, gunakan parameter bodyRaw untuk mengisi data body request ini(dalam string, tidak bisa mengirim file)
  static Future<dynamic> basicRequest(String url, BasicRequestUriParam? uriParam, RequestMethod method, BasicRequestHeader? header, FormRequestBody? body, {String? bodyRaw = null})async{
    late Request request;
    if(uriParam != null){
      request = http.Request(method.name, Uri.parse(url+uriParam.uriParam));
    }
    else{
      request = http.Request(method.name, Uri.parse(url));
    }

    if(body!=null) request.bodyFields = body.body;
    else if(bodyRaw != null) request.body = bodyRaw;

    if(header!=null) request.headers.addAll(header.header);

    http.StreamedResponse response = await request.send();
    var ret = await response.stream.bytesToString();

    if(response.statusCode == 200){
      try{
        return jsonDecode(ret);
      }
      catch(e){
        return ret;
      }
    }

    //kalo respons error, dia return null
    else{
      return null;
    }
  }
}

//=====================================================================================================
//kumpulan data class

enum RequestMethod{
  GET,
  PUT,
  POST,
  PATCH
}

/// untuk buat parameter uri.
///
/// **Misalnya url**: *http://www.example.org:56789/a/b/c.txt?t=win&s=chess#para5*
///
/// Mengandung Uri:
/// * t bernilai "win"
/// * s bernilai "chess"
///
/// **Contoh Penggunaan**
///
/// *BasicRequestUriParam().addKey("name", "Clara").addKey("age", "7")*
class BasicRequestUriParam{
  List<String> keys = [];
  List<String> values = [];

  String get uriParam{
    String ret = "";
    for(int x=0; x< keys.length; x++){
      if(x == 0){
        ret+="?";
      }
      else{
        ret+="&";
      }
      ret+="${keys[x]}=${values[x]}";
    }

    return ret;
  }

  /// digunakan untuk memasukkan parameter ke uri request ini. Sebenarnya ini bisa gak dipakai, langsung masukin uri ke url di baseRequest()
  /// Contoh penggunaan BasicRequestUriParam().addKey("name", "Clara").addKey("age", "7")
  BasicRequestUriParam addKey(String key, dynamic value){
    if(value != null){
      if(value is String){
        keys.add(key);
        values.add(value);
      }
      else if(value is DateTime){
        keys.add(key);
        values.add(value.year.toString()+"-"+value.month.koiToXDigit()+"-"+value.day.koiToXDigit());
      }
      else if(value is int){
        keys.add(key);
        values.add(value.toString());
      }
      else{
        throw AssertionError("Tipe data ini tidak didukung di fungsi BasicRequestUriParam.addKey() ini");
      }
    }
    return this;
  }
}

/// digunakan untuk memasukkan parameter header ke request, gunakan fungsi addKey().
///
/// **Contoh Penggunaan**
///
/// *BasicRequestHeader().addKey("Authorization", "1829741036").addKey("Content-Type", "application/json")*
class BasicRequestHeader{
  Map<String, String> _header ={};

  Map<String, String> get header => _header;

  /// digunakan untuk memasukkan parameter form ke body request
  /// Contoh penggunaan BasicRequestHeader().addKey("Authorization", "1829741036").addKey("Content-Type", "application/json")
  BasicRequestHeader addKey(String key, String value){
    _header[key] = value;
    return this;
  }
}

/// Request body dalam format json/form
/// 
/// > Untuk menambah parameter form ke body, gunakan fungsi addKey().
/// 
/// **Contoh:**
/// 
/// *FormRequestBody().addKey("name", "Clara").addKey("age", "7")*
class FormRequestBody{
  Map<String, String> _body ={};

  Map<String, String> get body =>  _body;

  /// digunakan untuk memasukkan parameter form ke body request
  /// Contoh penggunaan FormRequestBody().addKey("name", "Clara").addKey("age", 7)
  /// **NOTE**
  /// * data yang NULL tidak akan dimasukkan
  /// * Semua tipe data akan dikonvert jadi STRING, karena body request emang harus string
  /// * khusus untuk data tipe BOOLEAN akan otomatis diconvert jadi 0 atau 1
  /// * khusus tipe data DATETIME akan diconvert jadi string dengan format yyyy-mm-dd jj:mm:ss
  FormRequestBody addKey(String key, dynamic value){
    if(value!= null){

      if(value is bool){
        _body[key] = value ? "1" : "0";
      }
      if(value is DateTime){
        var val = value as DateTime;
        _body[key] = "${val.year}-${val.month}-${val.day} ${val.hour}:${val.minute}:${val.second}";
      }
      else{
        _body[key] = value.toString();
      }
    }
    return this;
  }
}
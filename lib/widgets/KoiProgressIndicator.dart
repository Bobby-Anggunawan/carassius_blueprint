import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// **Progress indicator**
class KoiProgressIndicator extends StatefulWidget {

  static int totalHistoryTercatatPerKey = 10;

  /// tampilkan ProgressIndicator selama x detik
  KoiProgressIndicator.showForSecond({Key? key, required int second}) :
        _second = second,
        _historyKey = null,
        super(key: key);
  /// tampilkan ProgressIndicator selama ? detik, tergantung histori dari key yang di pass
  KoiProgressIndicator.showBassedFromHistory({Key? key, required String historyKey}) :
        _second = null,
        _historyKey = historyKey,
        super(key: key);

  static SharedPreferences? prefs;

  final int? _second;
  final String? _historyKey;

  final DateTime initTime = DateTime.now();

  /// kalau pakai key, harus panggil fungsi ini untuk mencatat waktu yang dibutuhkan
  void recordHistoryOfKey(){

    if(_historyKey != null){

      List<int> listOfTimes = [];

      DateTime thisTime = DateTime.now();
      final List<String>? items = prefs?.getStringList(_historyKey!);

      if(items != null){
        items.forEach((element) {
          listOfTimes.add(int.tryParse(element) ?? 0);
        });
      }

      listOfTimes.add(initTime.difference(thisTime).inSeconds.abs());
      if(listOfTimes.length > totalHistoryTercatatPerKey){
        listOfTimes.removeAt(0);
      }

      List<String> ret = [];
      listOfTimes.forEach((element) {
        ret.add(element.toString());
      });

      prefs?.setStringList(_historyKey!, ret);
    }
  }

  @override
  State<KoiProgressIndicator> createState() => _KoiProgressIndicatorState();
}

class _KoiProgressIndicatorState extends State<KoiProgressIndicator> with SingleTickerProviderStateMixin {

  late AnimationController _controller;

  bool initStateSelesai = false;

  double counter = 0;

  void initController(int usedDuration){
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: usedDuration),
    )..addListener(() {
      setState(() {});
    });
    _controller.repeat(reverse: true);

    initStateSelesai = true;
    setState(() {
      print("initStateSelesai selesai");
    });
  }

  @override
  void initState(){
    super.initState();

    if(widget._second != null){
      initController(widget._second!);
      initStateSelesai = true;
    }
    else if (widget._historyKey != null){

      int usedDuration = 0;

      SharedPreferences.getInstance().then((value){
        KoiProgressIndicator.prefs = value;

        final List<String>? items = KoiProgressIndicator.prefs?.getStringList(widget._historyKey!);
        if(items != null){
          items.forEach((element) {
            if((int.tryParse(element) ?? 1) > usedDuration){
              usedDuration = int.tryParse(element) ?? 1;
            }
          });
        }
        else{
          usedDuration = 60*30;
        }

        initController(usedDuration);
        initStateSelesai = true;

      });
    }
    else{
      throw AssertionError("_historyKey atau _second tidak boleh kosong");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if(_controller.value > counter && _controller.value < 0.98){
      counter = _controller.value;
    }

    if(initStateSelesai){
      return Stack(
        children: [
          Center(
            child: Text("${(counter*100).ceil()}%"),
          ),
          Center(
            child: CircularProgressIndicator(
                color: context.koiThemeColor.primary,
                value: _controller.value,
                semanticsLabel: 'Circular progress indicator'
            ),
          )
        ],
      );
    }
    else{
      return SizedBox();
    }
  }
}

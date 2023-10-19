import "dart:async";

import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:video_player/video_player.dart";


/// builder untuk membuat halaman splashscreen.
/// biar tidak terus terus membuat splashscreen berulang kali tiap buat aplikasi baru
class KoiPageSplash extends StatefulWidget {
  const KoiPageSplash({Key? key, this.content, this.initialization, this.redirectTo, this.redirectAfter}) : super(key: key);

  /// apa yang ditampilkan selama splash screen. Jika ini null, maka widget default akan ditampilkan
  final Widget? content;

  /// fungsi yang dieksekusi di splash screen sebelum di redirect ke halaman lain
  ///
  /// **NOTE**
  ///
  /// Sebaiknya diakhir fungsi ini redirect ke halaman lain. Kalau tidak, halaman ini akan terus ditampilkan
  final Future<void> Function(BuildContext context)? initialization;

  /// optional, path pada route kemana user akan diarahkan saat fungsi [initialization] selesai. Jadi ini hanya diisi jika [initialization] tidak null. Jika [initialization] dan variable ini diisi, tidak ada yang akan terjadi
  final String? redirectTo;

  /// redirect setelah x detik. Kalau ini diisi, sebaiknya initialization tidak diisi. Jika keduanya diisi, yang selesai lebih dulu yang akan dijalankan
  final int? redirectAfter;

  @override
  State<KoiPageSplash> createState() => _KoiPageSplashState();
}

class _KoiPageSplashState extends State<KoiPageSplash> {

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

    if(widget.redirectAfter != null){
      Timer(
        Duration(seconds: widget.redirectAfter!),
          (){
            Navigator.of(context).pushNamed(widget.redirectTo!);
          }
      );
    }

    if(widget.initialization != null){
      widget.initialization!(context).then((value){
        if(widget.redirectTo != null){
          Navigator.of(context).pushNamed(widget.redirectTo!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.content ?? _DefaultSplash(),
    );
  }
}


class _DefaultSplash extends StatefulWidget {
  const _DefaultSplash({Key? key}) : super(key: key);

  @override
  State<_DefaultSplash> createState() => _DefaultSplashState();
}

class _DefaultSplashState extends State<_DefaultSplash> {

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('packages/carassius_blueprint/assets/ink-flows.mp4');

    _controller.initialize().then((_) => setState(() {
      _controller.setLooping(true);
      _controller.play();
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // TODO, periksa lagi scalenya, apa ada deviceyang gak pas?
    return Transform.scale(
      scaleX: 3,
      scaleY: 3,
      child: VideoPlayer(_controller),
    );
  }
}

import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:carassius_blueprint/extension/KoiFromBuildContext.dart';
import 'package:flutter/material.dart';

/// Untuk menambah layar:
///
/// * bisa dimasukkan ke parameter widget ini sesuai dengan target device (phone, tablet, laptop, dan desktop)
/// * bisa juga dengan menggunakan fungsi [KoiLayoutResponsive().setPhone()], sampai [KoiLayoutResponsive().setDesktop()]
///
/// > Widget ini akan otomatis menampilkan widget yang di pass ke parameternya sesuai dengan ukuran layar. Misalnya di mobile, widget akan menampilkan widget di parameter [screenPhone]
///
/// **Warning**
/// * widget ini akan error jika semua nilai dari screenPhone sampai screenDesktop semua null. Jika ada 1 saja yang tidak null, widget ini tidak error
///
/// **TODO**
/// * Sekarang cuma build sekali saja waktu pertama kali. Jadi kalau window di resize, ukuran tidak ikut berubah
class KoiLayoutResponsive extends StatefulWidget {
  const KoiLayoutResponsive({Key? key, this.updateWhenResize = false, this.screenPhone, this.screenTablet, this.screenLaptop, this.screenDesktop}) : super(key: key);

  final Widget? screenPhone;
  final Widget? screenTablet;
  final Widget? screenLaptop;
  final Widget? screenDesktop;

  /// defaultnya false.
  ///
  /// **Ketentuan**
  /// * kalau nilainya true, listener akan dibuat dan layout akan otomatis giganti jika resize
  /// * kalau nilainya false, listener tidak akan dibuat dan jika resize layout tidak diganti akan stay di layout pertama kali build
  ///
  /// **Note**
  ///
  /// Sebaiknya di set false saja buiar ringan
  final bool updateWhenResize;

  /// layar **Extra-small**
  KoiLayoutResponsive setPhone(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: screen,
        screenTablet: this.screenTablet,
        screenLaptop: this.screenLaptop,
        screenDesktop: this.screenDesktop,
        updateWhenResize: this.updateWhenResize
    );
  }

  /// layar **Small**
  KoiLayoutResponsive setTablet(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: screen,
        screenLaptop: this.screenLaptop,
        screenDesktop: this.screenDesktop,
        updateWhenResize: this.updateWhenResize
    );
  }

  /// layar **Medium**
  KoiLayoutResponsive setLaptop(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: this.screenTablet,
        screenLaptop: screen,
        screenDesktop: this.screenDesktop,
        updateWhenResize: this.updateWhenResize
    );
  }

  /// layar **Large**
  KoiLayoutResponsive setDesktop(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: this.screenTablet,
        screenLaptop: this.screenLaptop,
        screenDesktop: screen,
        updateWhenResize: this.updateWhenResize
    );
  }

  @override
  State<KoiLayoutResponsive> createState() => _KoiLayoutResponsiveState();
}

class _KoiLayoutResponsiveState extends State<KoiLayoutResponsive> {

  late ScreenBreakpoints lastBreakpoint;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    lastBreakpoint = context.koiBreakpoint;

  }

  Widget _returnFirstNotNull(BuildContext context){

    if(context.koiBreakpoint == ScreenBreakpoints.phone){
      return widget.screenPhone ?? widget.screenTablet ?? widget.screenLaptop ?? widget.screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.tablet){
      return widget.screenTablet ?? widget.screenPhone ?? widget.screenLaptop ?? widget.screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.laptop){
      return widget.screenLaptop ?? widget.screenTablet ?? widget.screenPhone ?? widget.screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.desktop){
      return widget.screenDesktop ?? widget.screenLaptop ?? widget.screenTablet ?? widget.screenPhone ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }

    throw UnimplementedError("KoiLayoutResponsive, error enum ScreenBreakpoints belum diimplementasikan");
  }

  @override
  Widget build(BuildContext context) {


    if([widget.screenPhone, widget.screenTablet, widget.screenLaptop, widget.screenDesktop].every((element) => (element == null))){
      throw ArgumentError("Semua agrument nilainya null. Paling tidak harus ada 1 widget yang di pass ke agrument widget ini");
    }

    if(widget.updateWhenResize){
      return NotificationListener(
        onNotification: (SizeChangedLayoutNotification notification){

          Future.delayed(Duration(milliseconds: 300),(){

            if(lastBreakpoint != context.koiBreakpoint){
              setState(() {
                lastBreakpoint = context.koiBreakpoint;
              });
            }

          });
          return true;
        },
        child: SizeChangedLayoutNotifier(
          child: _returnFirstNotNull(context),
        ),
      );
    }

    return _returnFirstNotNull(context);
  }
}

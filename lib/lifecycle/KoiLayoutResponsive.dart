import 'dart:js';

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
class KoiLayoutResponsive extends StatelessWidget {
  const KoiLayoutResponsive({Key? key, this.screenPhone, this.screenTablet, this.screenLaptop, this.screenDesktop}) : super(key: key);

  final Widget? screenPhone;
  final Widget? screenTablet;
  final Widget? screenLaptop;
  final Widget? screenDesktop;

  /// layar **Extra-small**
  KoiLayoutResponsive setPhone(Widget screen){
    return KoiLayoutResponsive(
      screenPhone: screen,
      screenTablet: this.screenTablet,
      screenLaptop: this.screenLaptop,
      screenDesktop: this.screenDesktop
    );
  }

  /// layar **Small**
  KoiLayoutResponsive setTablet(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: screen,
        screenLaptop: this.screenLaptop,
        screenDesktop: this.screenDesktop
    );
  }

  /// layar **Medium**
  KoiLayoutResponsive setLaptop(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: this.screenTablet,
        screenLaptop: screen,
        screenDesktop: this.screenDesktop
    );
  }

  /// layar **Large**
  KoiLayoutResponsive setDesktop(Widget screen){
    return KoiLayoutResponsive(
        screenPhone: this.screenPhone,
        screenTablet: this.screenTablet,
        screenLaptop: this.screenLaptop,
        screenDesktop: screen
    );
  }

  Widget _returnFirstNotNull(BuildContext context){

    if(context.koiBreakpoint == ScreenBreakpoints.phone){
      return screenPhone ?? screenTablet ?? screenLaptop ?? screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.tablet){
      return screenTablet ?? screenPhone ?? screenLaptop ?? screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.laptop){
      return screenLaptop ?? screenTablet ?? screenPhone ?? screenDesktop ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.desktop){
      return screenDesktop ?? screenLaptop ?? screenTablet ?? screenPhone ?? KoiPageError.NotImplemented(message: "Error, semua breakpoint tidak di set",);
    }

    throw UnimplementedError("KoiLayoutResponsive, error enum ScreenBreakpoints belum diimplementasikan");
  }

  @override
  Widget build(BuildContext context) {

    if([screenPhone, screenTablet, screenLaptop, screenDesktop].every((element) => (element == null))){
      throw ArgumentError("Semua agrument nilainya null. Paling tidak harus ada 1 widget yang di pass ke agrument widget ini");
    }

    return _returnFirstNotNull(context);
  }
}

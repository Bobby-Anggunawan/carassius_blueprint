import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

import "../extension/KoiFromBuildContext.dart";

/// Buat halaman dengan panel-panel yang responsif mengatur ulang tata letak sesuai dengan ukuran layar saat ini
///
/// Untuk membaca soal panes, dapat dilihat pada:
///
/// *https://m3.material.io/foundations/layout/understanding-layout/parts-of-layout#667b32c0-56e2-4fc2-a618-4066c79a894e*
/// 
/// **Note**
/// Meski widget ini dapat menghasilkan lebih dari 2 panes, tapi material design menyarankan hanya menggunakan 1 panes saja per layout
class KoiLayoutPanes extends StatelessWidget {
  const KoiLayoutPanes({Key? key, this.panes = const []}) : super(key: key);
  
  final List<Pane> panes;

  @override
  Widget build(BuildContext context) {

    //start-build rows
    List<Widget> rows = [];
    List<Widget> panesWidget = [];
    panes.forEach((element) {

      // pane flexible
      if(element.paneConfig.getPaneWidth(context).fixed == 0){
        panesWidget.add(element);
      }
      // pane tidak terlihat
      else if(element.paneConfig.getPaneWidth(context).fixed == -1){
        // abaikan saja, artinya pane tidak terlihat
      }
      // pane fullscreen
      else if(element.paneConfig.getPaneWidth(context).fixed == double.infinity){
        panesWidget.add(element);
        rows.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: panesWidget.toList(),
          )
        );
        panesWidget.clear();
      }
      // pane dengan ukuran fixed
      // todo [v], harusnya kalau ukuran lebih dari window, dibuat di line baru
      // todo, harusnya spacing antar pane juga dihitung. sekarang tidak
      else{
        if(KoiVariable.windowWidthDP > element.paneConfig.getPaneWidth(context).fixed){
          panesWidget.add(element);
        }
        else{
          panesWidget.add(element);
          rows.add(
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: panesWidget.toList(),
              )
          );
          panesWidget.clear();
        }
      }
    });
    if(panesWidget.isNotEmpty){
      rows.add(
          Row(
            children: panesWidget.toList(),
          )
      );
      panesWidget.clear();
    }
    //end---build rows


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: rows,
    );
  }
}


class Pane extends StatelessWidget {
  const Pane({Key? key, required this.paneConfig, required this.child, this.margin, this.color, this.borderRadius, this.elevation = 0}) : super(key: key);

  /// mengatur ukuran pane, fixed, flexible atau tidak ditampilkan
  final PaneConfig paneConfig;

  /// margin di pane ini
  ///
  /// **NOTE**
  ///
  /// Kalau null, margin otomatis akan menggunakan nilai dari [context.koiSpacing.autoFromScreenEdge]
  final EdgeInsetsGeometry? margin;

  /// Warna dari pane. Jika null akan menggunakan nilai dari [context.koiThemeColor.surface]
  final Color? color;

  /// Border radius dari pane
  ///
  /// **NOTE**
  ///
  /// Jika warna pane = [Colors.transparent], variable ini tidak berguna
  final BorderRadius? borderRadius;

  /// elevation dari pane(untuk efek bayangan)
  final double elevation;

  /// isi dari pane ini
  final Widget child;

  @override
  Widget build(BuildContext context) {

    var widgetToShow = Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: color,
      child: Padding(
        padding: margin ?? EdgeInsets.all(0),
        child: child,
      ),
    );

    // pane dihilangkan
    if(paneConfig.getPaneWidth(context).fixed == -1){
      return SizedBox();
    }
    // pane flexible
    else if(paneConfig.getPaneWidth(context).fixed == 0){
      return Flexible(
          child: widgetToShow
      );
    }

    // pane fullscreen
    else if(paneConfig.getPaneWidth(context).fixed == double.infinity){
      return Expanded(
          child: widgetToShow
      );
    }
    // pane fixed width
    else{
      return Container(
        width: paneConfig.getPaneWidth(context).fixed,
        child: widgetToShow,
      );
    }
  }
}

/// Mengatur ukuran pane. Gunakan fungsi fungsi
///
/// * setPhone()
/// * setTablet()
/// * setLaptop()
/// * setDesktop()
///
/// **Warning**
///
/// paling tidak harus ada 1 PaneWidth yang di set dengan semua fungsi diatas atau dengan constructor atau class ini akan mereturn error saat digunakan
class PaneConfig{

  PaneConfig({this.panePhone, this.paneDesktop, this.paneLaptop, this.paneTablet});

  /// layar **Extra-small**
  PaneConfig setPhone(PaneWidth config){
    return PaneConfig(
      panePhone: config,
      paneDesktop: paneDesktop,
      paneLaptop: paneLaptop,
      paneTablet: paneTablet
    );
  }

  /// layar **Small**
  PaneConfig setTablet(PaneWidth config){
    return PaneConfig(
        panePhone: panePhone,
        paneDesktop: paneDesktop,
        paneLaptop: paneLaptop,
        paneTablet: config
    );
  }

  /// layar **Medium**
  PaneConfig setLaptop(PaneWidth config){
    return PaneConfig(
        panePhone: panePhone,
        paneDesktop: paneDesktop,
        paneLaptop: config,
        paneTablet: paneTablet
    );
  }

  /// layar **Large**
  PaneConfig setDesktop(PaneWidth config){
    return PaneConfig(
        panePhone: panePhone,
        paneDesktop: config,
        paneLaptop: paneLaptop,
        paneTablet: paneTablet
    );
  }

  final PaneWidth? panePhone;
  final PaneWidth? paneTablet;
  final PaneWidth? paneLaptop;
  final PaneWidth? paneDesktop;

  PaneWidth getPaneWidth(BuildContext context){

    if([panePhone, paneTablet, paneLaptop, paneDesktop].every((element){return (element == null);})){
      throw AssertionError("Semua PaneWidth tidak boleh kosong");
    }

    if(context.koiBreakpoint == ScreenBreakpoints.phone){
      return panePhone ?? paneTablet ?? paneLaptop ?? paneDesktop ?? PaneWidth.disappear();
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.tablet){
      return paneTablet ?? panePhone ?? paneLaptop ?? paneDesktop ?? PaneWidth.disappear();
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.laptop){
      return paneLaptop ?? paneTablet ?? panePhone ?? paneDesktop ?? PaneWidth.disappear();
    }
    else if(context.koiBreakpoint == ScreenBreakpoints.desktop){
      return paneDesktop ?? paneLaptop ?? paneTablet ?? panePhone ?? PaneWidth.disappear();
    }

    throw UnimplementedError("KoiLayoutPanes, enum ScreenBreakpoints belum diimplementasikan");
  }
}

/// Mengatur ukuran pane apakah fixed atau fleksibel sesuai ukuran window
///
/// ada 2 constructor yang dapat digunakan:
/// * [PaneWidth.fixed(double value)]
/// * [PaneWidth.flexible()]
class PaneWidth{

  /// ukuran pane ini fixed tidak bisa berubah walau window resize
  PaneWidth.fixed(double value): fixed = value;

  /// ukuran pane ini akan berubah mengikuti perubahan ukuran window, mengisi sisa space kosong
  PaneWidth.flexible(): fixed = 0;

  /// kalau pane tidak terlihat
  PaneWidth.disappear(): fixed = -1;

  /// pane ini ukurannya sebesar ukuran layar
  PaneWidth.fullscreen(): fixed = double.infinity;

  /// kalau -1 artinya tidak terlihat, kalau infinity artinya flexible, selain itu fixed
  final double fixed;

}

import "package:flutter/material.dart";

/// container untuk widget lain. Seperti class [Container()] di [material.dart], bedanya ini sudah digabung dengan widget penting lain seperi [AspectRatio()] dan [Material()] agar pembuatan layout lebih cepat dan lebih tertata
class KoiContainer extends StatelessWidget {
  const KoiContainer({Key? key, this.width, this.height, this.ratio, required this.child, this.type = MaterialType.canvas, this.elevation = 0, this.borderRadius, this.margin, this.padding, this.color, this.alignment = Alignment.center}) : super(key: key);

  final double? width;
  final double? height;

  /// aspect ratio child dari widget ini. width atau height atau keduanya lebih baik diisi. size dari child akan mengikuti ratio ini(ukurannya disesuaikan dengan nilai width atau height)
  final Ratio? ratio;

  final Widget child;

  /// Apa container ini berjenis card(ada bayangan), hanya canvas(polos) atau yang lainnya. Digunakan widget [Material()]
  /// Defaultnya adalah canvas(polos)
  final MaterialType type;
  /// kekuatan bayangan jika type = card
  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  /// lokasi container(setelah resize menurut parameter [ratio]). Defaultnya adalah di tengah
  ///
  /// > Jadi misalnya [width] == 100 tapi karena [ratio], [width] disesuaikan dengan [height] hingga jadi misalnya 70. Jadi widget ini akan membuat suatu widget dengan lebar 100 dan widget lain di dalamnya dengan lebar 70 dan widget dengan lebar 70 di align di dalam widget lebar 100 berdasarkan parameter ini.
  final AlignmentGeometry alignment;

  final Color? color;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: padding,
      alignment: alignment,
      width: width,
      height: height,
      child: Material(
          type: type,
          elevation: elevation,
          borderRadius: borderRadius,
          color: color,
          child: Padding(
            padding: margin ?? EdgeInsets.zero,
            child: Builder(
              builder: (BuildContext context) {
                if(ratio == null){
                  return child;
                }
                else{
                  return AspectRatio(
                    aspectRatio: ratio!.getRatio(),
                    child: child,
                  );
                }
              },
            ),
          ),
      ),
    );
  }
}

/// perbandingan tinggi dan lebar. Misalnya 1:1, 3:2, 16:9
class Ratio{

  /// misalnya ratio 16:9 (landscape), isi dengan
  ///
  /// *Ratio(width:16, height:9)*
  Ratio({required this.width, required this.height});

  /// sama dengan 1:1
  Ratio.Square(): width = 1, height = 1;
  /// sama dengan 16:9
  Ratio.LandscapeLong(): width = 16, height = 9;
  /// sama dengan 3:2
  Ratio.LandscapeMedium(): width = 3, height = 2;
  /// sama dengan 4:3
  Ratio.LandscapeShort(): width = 4, height = 3;
  /// sama dengan 3:4
  Ratio.PortraitShort(): width = 3, height = 4;
  /// sama dengan 2:3
  Ratio.PortraitTall(): width = 2, height = 3;


  final int width;
  final int height;

  /// fungsi yang digunakan oleh widget [AspectRatio]
  double getRatio(){
    return width/height;
  }
}

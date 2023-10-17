import "package:flutter/material.dart";

import "../extension/KoiFromBuildContext.dart";

/// container untuk widget lain. Seperti class [Container()] di [material.dart], bedanya ini sudah digabung dengan widget penting lain seperi [AspectRatio()] dan [Material()] agar pembuatan layout lebih cepat dan lebih tertata
///
/// **Note**
///
/// > jika parameter [ratio] diisi, hanya salahsatu [width] atau [height] yang perlu di set, yang lainnya yang null akan otomatis menyesuaikan ukuran berdasarkan parameter [ratio]
class KoiContainer extends StatelessWidget {
  const KoiContainer({Key? key, this.width, this.height, this.ratio, required this.child, this.type = MaterialType.canvas, this.elevation = 0, this.borderRadius, this.margin, this.padding, this.color, this.alignment = Alignment.center}) : super(key: key);

  /// Constructor membuat card.
  ///
  /// Constructor ini akan memberi nilai default ke [type], [margin], [borderRadius] sesuai saran material design pada
  ///
  /// *https://m3.material.io/components/cards/specs*
  KoiContainer.card({Key? key, this.width, this.height, this.ratio, required this.child, MaterialType? type, this.elevation = 1, BorderRadiusGeometry? borderRadius, EdgeInsetsGeometry? margin, this.padding, this.color, this.alignment = Alignment.center}):
        margin = margin ?? EdgeInsets.all(SpacingSize().large),
        borderRadius = borderRadius ?? BorderRadius.circular(SpacingSize().medium),
        type = type ?? MaterialType.card,
        super(key: key);


  final double? width;
  final double? height;

  /// aspect ratio child dari widget ini. Jika diisi, parameter [width] atau [height] lebih baik hanya diisi salahsatu saja jangan keduanya. Size dari child akan mengikuti ratio ini(ukurannya disesuaikan dengan nilai width atau height yang tidak null)
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
  ///
  /// **Constructor lain:**
  /// * Ratio.Square()
  /// * Ratio.LandscapeLong()
  /// * Ratio.LandscapeMedium()
  /// * Ratio.LandscapeShort()
  /// * Ratio.PortraitShort()
  /// * Ratio.PortraitTall()
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

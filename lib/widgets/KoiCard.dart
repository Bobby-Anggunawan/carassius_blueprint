import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

//todo, ambil referensi dari sini https://mui.com/material-ui/react-card/
/*
* Struktur
header
media
content
action*/
class KoiCard extends StatelessWidget {
  const KoiCard({Key? key, required this.orientation, required this.header, required this.media, Ratio? ratioMediaPortrait, Ratio? ratioMediaLandscape, required this.content, required this.action, this.actionAlignment = MainAxisAlignment.end, this.width, this.height, this.borderRadius, this.ratio, this.elevation = 1}):
        ratioMediaLandscape = ratioMediaLandscape ?? const Ratio.Square(),
        ratioMediaPortrait = ratioMediaPortrait ?? const Ratio.LandscapeMedium(),
        super(key: key);

  /// apa card portrait atau landscape. Sebaiknya gunakan [Orientation.portrait]. Jika card terlalu besar misalnya di mobile, baru gunakan [Orientation.landscape]
  ///
  /// **Ilustrasi**
  /// *https://lh3.googleusercontent.com/uVqBzd6Old0bCx9MyHlDpgarxTLyKL06leFX9NJkviJIZHGXDHHezi4I7LX5ZPiPP1VC2qMDhO2KpTMQ_fMsGcDMZpgCDseb7LtokYebTkn0=s0*
  final Orientation orientation;

  /// Widget yang letaknya paling atas di card
  ///
  /// **Saran:**
  ///
  /// Daftar widget yang disarankan diisi di sini adalah
  /// * ListTitle(): karena sudah dilengkapi dengan title, subtitle, leading dan heading(diasa dipakai untuk menampilkan menu di card ini)
  /// * Text()
  ///
  /// **Note**
  ///
  /// Kalau widget [ListTitle] dimasukkan ke sini, padding dari ListTitle akan dihapus otomatis agar sejajar dengan text/[content]
  final Widget? header;

  /// Widget yang menampilkan multimedia letaknya dibawah [header].
  ///
  /// **Saran:**
  ///
  /// Daftar widget yang disarankan diisi di sini adalah
  /// * Image()
  final Widget? media;
  /// ratio widget [media] jika [orientation] == [Orientation.portrait]
  ///
  /// **Note**
  ///
  /// Nilai default = [Ratio.LandscapeMedium()]
  final Ratio ratioMediaPortrait;
  /// ratio widget [media] jika [orientation] == [Orientation.portrait]
  ///
  /// **Note**
  ///
  /// Nilai default = [Ratio.Square()]
  final Ratio ratioMediaLandscape;

  /// Isi dari card ini. letaknya dibawah [media]
  ///
  /// **Saran**
  ///
  /// Daftar widget yang disarankan diisi di sini adalah
  /// * Text()
  /// * Wrap(), Row(), Column() : jika content terdiri dari beberapa widget lain
  final Widget? content;

  /// daftar tombol yang ditampilkan di paling bawah card
  ///
  /// **Note**
  ///
  /// List ini akan dimasukkan ke widget [Row()], jadi widget seperti [Expanded()] dapat digunakan di sini untuk mengatur posisi
  ///
  /// **Saran**
  ///
  /// Daftar widget yang disarankan diisi di sini adalah
  /// * TextButton()
  final List<Widget> action;

  /// Alignment dari tombol action. Secara default ke kanan
  final MainAxisAlignment actionAlignment;


  final Ratio? ratio;
  /// tinggi card ini.
  ///
  /// **Note**
  ///
  /// Kalau card landscape, sebaiknya height diisi biar gak overflow
  final double? height;
  final double? width;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {

    if(orientation == Orientation.landscape){
      if(height == null && (ratio == null && width == null) && media != null){
        throw AssertionError("Kalau card landscape, sebaiknya height diisi biar gak overflow :)");
      }
    }

    double? headerPadding = context.koiSpacing.large;
    if(header is ListTile || header == null){
      headerPadding = 0;
    }

    double?  mediaPadding = 0;
    if(header != null && content != null){
      mediaPadding = context.koiSpacing.large;
    }

    if(orientation == Orientation.portrait){
      return KoiContainer.card(
          margin: EdgeInsets.zero,
          ratio: ratio,
          height: height,
          width: width,
          elevation: elevation,
          borderRadius: borderRadius,
          child: Column(
            mainAxisSize: (height == null || ratio == null) ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Builder(builder: (context){
                if(headerPadding == 0 && header == null){
                  return SizedBox();
                }
                else{
                  return Padding(padding: EdgeInsets.only(top: context.koiSpacing.small));
                }
              }),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: headerPadding, vertical: headerPadding),
                child: header,
              ),
              Builder(builder: (context){
                if(media != null){
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: mediaPadding ?? 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(SpacingSize().medium),
                        child: AspectRatio(
                          aspectRatio: ratioMediaPortrait.getRatio(),
                          child: FittedBox(
                            child: media,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                  );
                }
                return SizedBox();
              }),
              Padding(
                padding: EdgeInsets.all(context.koiSpacing.large),
                child: content,
              ),
              Padding(
                padding: EdgeInsets.only(left: context.koiSpacing.large, right: context.koiSpacing.large, bottom: context.koiSpacing.largest),
                child: Row(
                  mainAxisAlignment: actionAlignment,
                  children: action,
                ),
              )
            ],
          )
      );
    }
    else{
      return KoiContainer.card(
          margin: EdgeInsets.zero,
          ratio: ratio,
          height: height,
          width: width,
          elevation: elevation,
          borderRadius: borderRadius,
          child: Row(
            mainAxisSize: (width == null && ratio == null) ? MainAxisSize.min : MainAxisSize.max,
            children: [

              Builder(builder: (context){
                if(media != null){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(SpacingSize().medium),
                    child: AspectRatio(
                      aspectRatio: ratioMediaLandscape.getRatio(),
                      child: FittedBox(
                        child: media,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
                return SizedBox();
              }),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: (height == null && ratio == null) ? MainAxisSize.min : MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Builder(builder: (context){
                        if(headerPadding == 0 && header == null){
                          return SizedBox();
                        }
                        else{
                          return Padding(padding: EdgeInsets.only(top: context.koiSpacing.small));
                        }
                      }),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: headerPadding, vertical: headerPadding),
                        child: header,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(context.koiSpacing.large, 0, context.koiSpacing.large, context.koiSpacing.large),
                        child: content,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: context.koiSpacing.large, right: context.koiSpacing.large, bottom: context.koiSpacing.largest),
                        child: Row(
                          mainAxisAlignment: actionAlignment,
                          children: action,
                        ),
                      )
                    ],
                  ),
                )
              )
            ],
          )
      );
    }
  }
}

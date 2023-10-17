import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

// TODO!! kalau bisa di KoiScaffold juga buat fungsi generate builder untuk spinner supaya orang yang gak pakai KoiScaffold tetap bisa pakai spinnernya

/// Struktur dasar aplikasi, memuat routing, templating, dan lain-lain.
/// > Cara penggunaannya tinggal masukkan saja ke fungsi **main()** di **main.dart**
///
/// **Parameter**
/// * routes: Diisi dengan halaman halaman yang ada di aplikasi ini. Merupakan implementasi dari https://docs.flutter.dev/cookbook/navigation/named-routes
/// * themeColor: Diisi dengan warna yang ingin digunakan aplikasi. Di dalam class ini disimpan 2 jenis theme warna, dark theme dan light theme Umumnya warna yang ditampilkan adalah warna di light theme dan sedangkan dark theme hanya ditampilkan di perangkat mobile jika device di setting dark mode. Merupakan implementasi dari https://m3.material.io/styles/color/the-color-system/key-colors-tones
///
/// **Contoh**
///
/// `main(){runApp(KoiScaffold(<parameters>))}`
class KoiScaffold extends StatelessWidget {
  const KoiScaffold({Key? key, required this.routes, required this.themeColor, this.textTheme = null, this.builder = null, this.spinner = null}) : super(key: key);

  static ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);

  /// kalau true, spinner akan ditampilkan. Kalau false spinner tidak tampil
  static set isLoading(bool value){
    _isLoading.value = value;
  }

  //============================================

  /// warna dari template aplikasi ini. Warna saat light mode dan dark mode tersimpan di sini
  ///
  /// **Note**, gunakan constructor [ThemeColor.autoGenerateFromColor()] agar bisa lebih cepat, tidak perlu memikirkan warna lain, hanya perlu memilih warna utama saja
  final ThemeColor themeColor;

  /// typography di aplikasi ini
  final TextTheme? textTheme;

  final KoiScaffoldRoute routes;

  /// builder untuk dimasukkan ke [MaterialApp].
  ///
  /// Terkadang ada library yang perlu ini misalnya: *https://pub.dev/packages/flutter_easyloading*
  final Widget Function(BuildContext, Widget?)? builder;

  /// widget yang ditampilkan sebagai overlay jika sedang loading (variable [isLoading] diset true). Jika null widget [Spinner()] akan ditampilkan
  final Widget? spinner;

  @override
  Widget build(BuildContext context) {

    //start-buat ThemeData
    ThemeData lightTheme = ThemeData(
        colorScheme: themeColor.lightTheme,
        textTheme: textTheme
    );

    bool adaDarkTheme = false;
    ThemeData? darkTheme;
    if(themeColor.darkTheme != null){
      adaDarkTheme = true;
    }

    if(adaDarkTheme){
      darkTheme = ThemeData(
        colorScheme: themeColor.darkTheme,
        textTheme: textTheme
      );
    }
    //end---buat ThemeData

    return MaterialApp(
      routes: routes.getRoutes(),
      theme: lightTheme,
      darkTheme: darkTheme,
      builder: (context, child){
        if(builder != null){
          child = builder!(context, child);
        }
        return Stack(
          children: [
            child!,
            ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (BuildContext context, bool value, Widget? child){
                  if(value){
                    return spinner ?? Center(child: CircularProgressIndicator(),);
                  }
                  return SizedBox();
                }
            ),
          ],
        );
      }
    );
  }
}

//============================================================================
// class class yang dipakai

class ThemeColor{

  late ColorScheme lightTheme;
  ColorScheme? darkTheme;

  /// Mengatur warna theme dengan object ColorScheme.
  ///
  /// > Light Theme memang wajib diisi. Jika ingin mengisi Dark Theme, gunakan fungsi [setDarkTheme()]
  ///
  /// **Note**, jika kesulitan membuat object ColorScheme, bisa langsung menggunakan constructor [autoGenerateFromColor()]
  ThemeColor.setLightTheme(ColorScheme themeColor){
    lightTheme = themeColor;
  }

  /// otomatis membuat [ColorScheme] dari sebuah warna. Fungsi ini menghasilkan [ColorScheme] untuk light mode dan dark mode bersamaan.
  ///
  /// **Contoh**
  /// > [ThemeColor.autoGenerateFromColor(Colors.red)]
  ThemeColor.autoGenerateFromColor(Color color){
    lightTheme = ColorScheme.fromSeed(seedColor: color);
    darkTheme = ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark);
  }

  /// fungsi optional untuk mengisi warna theme dark mode.
  ///
  /// **Note**, fungsi ini tidak perlu dipanggil jika object ini dibuat pakai constructor [autoGenerateFromColor()]. Hanya dipanggil jika object ini dibuat dengan constructor [setLightTheme()]
  ThemeColor setDarkTheme(ColorScheme themeColor){
    darkTheme = themeColor;
    return this;
  }
}

/// Routing untuk [KoiScaffold]
///
/// **Cara menggunakan**:
/// * Gunakan fungsi [addRoutes] untuk memasukkan route
class KoiScaffoldRoute{

  Map<String, WidgetBuilder> _routes = {};

  /// tempat menyimpan semua route di aplikasi ini.
  /// variable ini dibutuhkan di class [StartingApp]
  Map<String, WidgetBuilder> getRoutes(){
    if(_routes.isEmpty){
      throw AssertionError("KoiScaffoldRoute._routes tidak boleh kosong. Tambah route dengan KoiScaffoldRoute.addRoutes()");
    }
    return _routes;
  }


  /// masukkan halaman awal di aplikasi ini. Biasanya yang dimasukkan ke sini adalah halaman Splash Screen
  ///
  /// **Note**, route dari halaman ini otomatis akan jadi "/"
  KoiScaffoldRoute.baseRoute(Widget page){
    _routes["/"] = (context) => page;
  }


  /// digunakan untuk mendaftarkan route baru
  ///
  /// Daftar parameter:
  /// * parameter [route] adalah nama dari route yang ingin dimasukkan, misalnya "/home". Jadi nama wajib dimulai dari "/" atau akan mereturn error
  KoiScaffoldRoute addRoutes(String route, Widget page){
    if(route[0] == "/"){
      _routes[route] = (context) => page;
      return this;
    }
    else{
      throw AssertionError('Parameter route harus dimulai dari karakter "/"');
    }
  }
}

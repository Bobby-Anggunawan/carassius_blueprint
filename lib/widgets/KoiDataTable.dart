import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:flutter/material.dart';


class KoiDataTable extends StatelessWidget {
  const KoiDataTable({Key? key, required this.columns, required this.row, this.borderColor = Colors.black, this.backgroudColor = Colors.white}) : super(key: key);

  /// warna border.. Default hitam
  final Color borderColor;
  /// warna background dari tabel ini
  final Color backgroudColor;

  /// list kolom kolom yang ada di dalam tabel, berurutan dari kiri ke kanan
  final List<KoiDataTableColumn> columns;
  /// list row yang ada di dalam tabel. Isinya list yang menggambarkan data per baris.
  ///
  /// **WARNING**
  /// kalau jumlah item dalam list di bagian dalam tidak sama dengan jumlah item dalam list di parameter [columns], widget ini akan mereturn error
  final List<List<Widget>> row;


  double countCombinedWidth(){

    double ret = 0;
    columns.forEach((element) {
      ret+= element.size;
    });

    /*
    3 kolom
      |a|b|c| = 4 garis
    4 kolom
      |a|b|c|d| = 5 garis
    5 kolom
      |a|b|c|d|e| = 6 garis
    */
    double totalLebarDividerDanBorder = columns.length + 1;

    return ret+totalLebarDividerDanBorder;
  }

  @override
  Widget build(BuildContext context) {

    if(row.isNotEmpty){
      for(int x=0; x< row.length; x++){
        if(columns.length != row[x].length){
          throw FlutterError("Jumlah kolom di [row] dan [columns] tidak sama. Ada ${columns.length} item dalam [columns] tapi [row] indeks ${x} mengandung ${row[x].length} item");
        }
      }
    }

    /*
    * Metode yang sekarang dipakai untuk menambahkan header
    * - build widget header lebih dahulu
    * - tampung header di suatu variable(karena akan dipakai lebih dari sekali)
    * - sisipkan header di item pertama list
    * - timpa header di atas widget list dengan widget stack
    * - note header yang [ertama disisipkan berguna untuk menurunkan item di list supaya header di stack tidak menimpa item pertama*/


    var header = KoiDataTableItems(column: null, config: columns, isLastItem: true, borderColor: borderColor, backgroudColor: backgroudColor,);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: countCombinedWidth(),
        child: Stack(
          children: [
            ListView.builder(
                itemCount: row.length+1,
                itemBuilder: (context, indeks){

                  if(indeks == 0){
                    return header;
                  }

                  return KoiDataTableItems(
                    config: columns,
                    column: List.generate(row[indeks-1].length, (indexCol){
                      return row[indeks-1][indexCol];
                    }),
                    isLastItem: row.length == indeks,
                    borderColor: borderColor,
                    backgroudColor: backgroudColor,
                  );
                }
            ),
            Container(
              width: countCombinedWidth(),
              child: header,
            )
          ],
        ),
      ),
    );
  }
}

class KoiDataTableItems extends StatelessWidget {
  const KoiDataTableItems({Key? key, required this.column, required this.config, required this.isLastItem, required this.borderColor, required this.backgroudColor}) : super(key: key);

  final List<Widget>? column;
  final List<KoiDataTableColumn> config;

  /// note, semua baris di sini hanya memiliki border diatas, dan dibawahnya tidak ada border
  /// Kalau tidak seperti ini, nanti garis di tengah(antara satu kolom dan kolom dibawahnya) jadi doble, terlihat lebih besar
  /// Tapi kalau semua baris cuma buat garis diatas, nanti item paling bawah jadi tidak ada border bawahnya
  /// Makanya dibuat variable ini untuk menandai apa ini item paling bawah
  /// Jadi item paling bawah, dibuat border semua sisi
  final bool isLastItem;

  final Color borderColor;

  final Color backgroudColor;

  @override
  Widget build(BuildContext context) {

    // untuk build baris
    if(column != null){
      return Container(
        decoration: BoxDecoration(
            color: backgroudColor,
            border: isLastItem ? Border.all(color: borderColor) : Border(
                left: BorderSide(color: borderColor),
                right: BorderSide(color: borderColor),
                top: BorderSide(color: borderColor)
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: List<Widget>.generate(column!.length, (index){

              /*return SizedBox(
              width: config[index].size,
              child: column[index],
            );*/

              return SizedBox(
                width: config[index].size,
                child: column![index],
              );
            }).koiAddBetweenElement(
                Container(
                  color: borderColor,
                  width: 1,
                )
            ),
          ),
        ),
      );
    }

    // untuk build header
    else{
      return Container(
        decoration: BoxDecoration(
            color: backgroudColor,
            border: isLastItem ? Border.all(color: borderColor) : Border(
                left: BorderSide(color: borderColor),
                right: BorderSide(color: borderColor),
                top: BorderSide(color: borderColor)
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: List<Widget>.generate(config.length, (index){

              /*return SizedBox(
              width: config[index].size,
              child: column[index],
            );*/

              return SizedBox(
                width: config[index].size,
                child: config[index].title,
              );
            }).koiAddBetweenElement(
                Container(
                  color: borderColor,
                  width: 1,
                )
            ),
          ),
        ),
      );
    }
  }
}

class KoiDataTableColumn{
  const KoiDataTableColumn({
    required this.title,
    this.size = 100
  });

  /// nama kolom ini
  final Widget title;

  /// lebar dari kolom ini
  /// kalau null artinya sizenya otomatis
  /// kalau tidak null, sizenya mengikuti angka yang dimasukkan
  final double size;
}
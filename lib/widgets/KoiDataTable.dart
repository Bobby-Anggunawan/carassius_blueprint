import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


enum SortDirections{
  Ascending,
  Descending,
  None
}

class JustSortDirectionsState extends ChangeNotifier{

  JustSortDirectionsState({SortDirections directions = SortDirections.None}){
    _directions = directions;
  }

  late SortDirections _directions;

  SortDirections get directions{
    return _directions;
  }
  set directions(SortDirections value){
    _directions = value;
    notifyListeners();
  }
}

/// masih dalam progress
///
/// TODO:
/// * buat supaya bisa ambil data dari api langsung(proses loading, sorting, paging, dll semua di handle di sini, user tinggal memasukkan url apu)
class KoiDataTable extends StatelessWidget {
  const KoiDataTable({
    Key? key,
    required this.columns,
    required this.row,
    this.backgroudColor = Colors.white,
    this.rowMinHeight = 52,
    this.headerMinHeight = 56,
    this.cellContentAlignment = Alignment.centerLeft,
    this.borderInnerVertical = BorderSide.none,
    this.borderInnerHorizontal = const BorderSide(color: Colors.black),
    this.borderOuter = const BorderSide(color: Colors.black),
    this.cellContentpadding = const EdgeInsets.symmetric(horizontal: 16),
    this.onSort = null,
  }) : super(key: key);

  /// tinggi minimal tiap row. Default **52** dapat dari:
  ///
  /// *https://m2.material.io/components/data-tables#anatomy*
  final double rowMinHeight;
  /// tinggi minimal header. Default **56** dapat dari:
  ///
  /// *https://m2.material.io/components/data-tables#anatomy*
  final double headerMinHeight;

  /// spacing antar kolom. Default **16** dapat dari:
  ///
  /// *EdgeInsets.symmetric(horizontal: 16)*
  ///
  /// *https://m2.material.io/components/data-tables#anatomy*
  final EdgeInsets cellContentpadding;

  /// warna background dari tabel ini
  final Color backgroudColor;

  /// Alignment semua item di dalam cell. Defaultnya [Alignment.centerLeft]
  /// Note, ini diaplikasikan sama untuk content di row dan header
  final Alignment cellContentAlignment;


  //###################################
  /// Border item vertical(border antar kolom).
  /// Default: [BorderSide.none]
  final BorderSide borderInnerVertical;
  /// Border item horizontal(border antar baris).
  /// Default: [BorderSide(color: Colors.black)]
  final BorderSide borderInnerHorizontal;
  /// Border di sisi luar tabel ini.
  /// Default: [BorderSide(color: Colors.black)]
  final BorderSide borderOuter;
  //###################################

  /// list kolom kolom yang ada di dalam tabel, berurutan dari kiri ke kanan
  final List<KoiDataTableColumn> columns;
  /// list row yang ada di dalam tabel. Isinya list yang menggambarkan data per baris.
  ///
  /// **WARNING**
  /// kalau jumlah item dalam list di bagian dalam tidak sama dengan jumlah item dalam list di parameter [columns], widget ini akan mereturn error
  final List<List<Widget>> row;

  /// fungsi yang dipanggil kalau tombol sort ditekan di header
  final void Function(int indexSortedColumn, List<SortDirections> allColumnDirection)? onSort;

  double countCombinedWidth(){

    double ret = 0;
    columns.forEach((element) {
      ret+= element.size;
    });

    return ret;
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


    var header = KoiDataTableItems(
      column: null,
      config: columns,
      isLastItem: true,
      backgroudColor: backgroudColor,
      rowMinHeight:  rowMinHeight,
      cellContentAlignment: cellContentAlignment,
      borderInnerHorizontal: borderInnerHorizontal,
      borderInnerVertical: borderInnerVertical,
      borderOuter: borderOuter,
      headerMinHeight: headerMinHeight,
      cellContentpadding: cellContentpadding,
      onSort: onSort,
    );

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
                    backgroudColor: backgroudColor,
                    rowMinHeight:  rowMinHeight,
                    cellContentAlignment: cellContentAlignment,
                    borderInnerHorizontal: borderInnerHorizontal,
                    borderInnerVertical: borderInnerVertical,
                    borderOuter: borderOuter,
                    headerMinHeight: headerMinHeight,
                    cellContentpadding: cellContentpadding,
                    onSort: onSort,
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
  const KoiDataTableItems({
    Key? key,
    required this.column,
    required this.config,
    required this.isLastItem,
    required this.backgroudColor,
    required this.rowMinHeight,
    required this.headerMinHeight,
    required this.cellContentAlignment,
    required this.borderInnerVertical,
    required this.borderInnerHorizontal,
    required this.borderOuter,
    required this.cellContentpadding,
    required this.onSort
  }) : super(key: key);

  final List<Widget>? column;
  final List<KoiDataTableColumn> config;


  //###################################
  /// Border item vertical(border antar kolom).
  /// Default: [BorderSide.none]
  final BorderSide borderInnerVertical;
  /// Border item horizontal(border antar baris).
  /// Default: [BorderSide(color: Colors.black)]
  final BorderSide borderInnerHorizontal;
  /// Border di sisi luar tabel ini.
  /// Default: [Border.all(color: Colors.black)]
  final BorderSide borderOuter;
  //###################################


  /// note, semua baris di sini hanya memiliki border diatas, dan dibawahnya tidak ada border
  /// Kalau tidak seperti ini, nanti garis di tengah(antara satu kolom dan kolom dibawahnya) jadi doble, terlihat lebih besar
  /// Tapi kalau semua baris cuma buat garis diatas, nanti item paling bawah jadi tidak ada border bawahnya
  /// Makanya dibuat variable ini untuk menandai apa ini item paling bawah
  /// Jadi item paling bawah, dibuat border semua sisi
  final bool isLastItem;

  final Color backgroudColor;

  final double rowMinHeight;
  final double headerMinHeight;
  final EdgeInsets cellContentpadding;

  final Function(int indexSortedColumn, List<SortDirections> allColumnDirection)? onSort;

  final Alignment cellContentAlignment;

  @override
  Widget build(BuildContext context) {

    // untuk build baris
    if(column != null){
      return Container(
        decoration: BoxDecoration(
            color: backgroudColor,
            border: Border(
              bottom: isLastItem == false ? borderInnerHorizontal : BorderSide.none,
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: List<Widget>.generate(column!.length, (index){

              // set min height berdasarkan: https://m2.material.io/components/data-tables#anatomy
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                      right: config.length-1 != index ? borderInnerVertical : borderOuter,
                      left: index == 0 ? borderOuter : BorderSide.none,
                      bottom: isLastItem ? borderOuter : BorderSide.none
                  )
                ),
                constraints: BoxConstraints(
                  minHeight: rowMinHeight
                ),
                width: config[index].size,
                child: Padding(
                  padding: cellContentpadding,
                  child: Align(
                    alignment: cellContentAlignment,
                    child: column![index],
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }

    // untuk build header
    else{
      return Container(
        decoration: BoxDecoration(
            color: backgroudColor,
            border: Border(
              bottom: borderInnerHorizontal
            )
        ),
        child: IntrinsicHeight(
          child: Row(
            children: List<Widget>.generate(config.length, (index){

              // set min height berdasarkan: https://m2.material.io/components/data-tables#anatomy
              return Container(
                decoration: BoxDecoration(
                    border: Border(
                      right: config.length-1 != index ? borderInnerVertical : borderOuter,
                      left: index == 0 ? borderOuter : BorderSide.none,
                      top: borderOuter
                    )
                ),
                constraints: BoxConstraints(
                  minHeight: headerMinHeight
                ),
                width: config[index].size,
                child: Padding(
                  padding: cellContentpadding,
                  child: Align(
                    alignment: cellContentAlignment,
                    child: config[index].canSort == false ?
                    config[index].title :
                    Row(
                      children: [
                        config[index].title,


                        ChangeNotifierProvider(
                            create: (context) => JustSortDirectionsState(),
                            builder: (context, child){
                              return Consumer<JustSortDirectionsState>(builder: (context, myViewModel, widget){
                                return IconButton(
                                    onPressed: (){

                                      late SortDirections nextDir;
                                      if(config[index].directions == SortDirections.Ascending){
                                        nextDir = SortDirections.Descending;
                                      }
                                      else{
                                        nextDir = SortDirections.Ascending;
                                      }

                                      myViewModel.directions = nextDir;
                                      config[index].directions = nextDir;

                                      //Function(int indexSortedColumn, List<SortDirections> allColumnDirection)? onSort
                                      if(onSort != null){

                                        List<SortDirections> allColumnDirection = [];
                                        config.forEach((element) {
                                          allColumnDirection.add(element.directions);
                                        });


                                        onSort!(index, allColumnDirection);
                                      }

                                    },
                                    icon: Icon(
                                        config[index].directions == SortDirections.None ?  Icons.unfold_more_sharp :
                                        config[index].directions == SortDirections.Ascending ? Icons.arrow_drop_down_sharp :
                                        config[index].directions == SortDirections.Descending ? Icons.arrow_drop_up_sharp :
                                        Icons.error
                                    )
                                );
                              });
                            }
                        ),
                      ],
                    )
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }
  }
}

class KoiDataTableColumn{
  KoiDataTableColumn({
    required this.title,
    this.size = 100,
    this.canSort = false,
    this.directions = SortDirections.None
  });

  /// nama kolom ini
  final Widget title;

  /// lebar dari kolom ini
  /// kalau null artinya sizenya otomatis
  /// kalau tidak null, sizenya mengikuti angka yang dimasukkan
  final double size;

  /// apa kolom ini bisa di sort
  /// Defaultnya false
  final bool canSort;

  /// sort directions saat ini. default [none]
  SortDirections directions;
}
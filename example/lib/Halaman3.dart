import "package:flutter/material.dart";
import 'package:carassius_blueprint/carassius_blueprint.dart';


class Halaman3 extends StatelessWidget {
  const Halaman3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KoiDataTable(

        borderInnerVertical: BorderSide(
            color: Colors.blue,
            width: 1
        ),
        borderInnerHorizontal: BorderSide(
            color: Colors.red,
            width: 1
        ),

        borderOuter: BorderSide(
            color: Colors.green,
            width: 1
        ),

        columns: [
          KoiDataTableColumn(
            title: Text("satu"),
            canSort: true,
            size: 400
          ),
          KoiDataTableColumn(
              title: Text("dua"),
              size: 400
          ),
          KoiDataTableColumn(
              title: Text("tiga"),
              size: 400
          ),
          KoiDataTableColumn(
              title: Text("empat"),
              size: 400
          ),
        ],
        row: [
          [Text("1"), Text("2"), Text("3"), Text("4"),],
          [Text("2"), Text("2"), Text("3"), Text("4"),],
          [Text("3"), Text("2"), Text("3"), Text("4"),],
          [Text("4"), Text("2"), Text("3"), Text("4"),],
          [Text("5"), Text("2"), Text("3"), Text("4"),],
          [Text("6"), Text("2"), Text("3"), Text("4"),],
          [Text("7"), Text("2"), Text("3"), Text("4"),],
          [Text("8"), Text("2"), Text("3"), Text("4"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
          [Text("9"), Text("2"), Text("3"), Text("ada orang makan ikan asin tapi direbus pakai air cabe"),],
        ],
      ),
    );
  }
}

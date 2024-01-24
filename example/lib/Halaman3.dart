import "package:flutter/material.dart";
import 'package:carassius_blueprint/carassius_blueprint.dart';


class Halaman3 extends StatelessWidget {
  const Halaman3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KoiDataTable(
        columns: [
          KoiDataTableColumn(
            title: Text("satu")
          ),
          KoiDataTableColumn(
              title: Text("dua")
          ),
          KoiDataTableColumn(
              title: Text("tiga")
          ),
          KoiDataTableColumn(
              title: Text("empat")
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
          [Text("9"), Text("2"), Text("3"), Text("4"),],
        ],
      ),
    );
  }
}

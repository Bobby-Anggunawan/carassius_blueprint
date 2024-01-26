import 'package:carassius_blueprint/carassius_blueprint.dart';
import 'package:carassius_blueprint/lifecycle/carassius_scaffold.dart';
import 'package:flutter/material.dart';

class HalamanResponsive extends StatelessWidget {
  const HalamanResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KoiLayoutPanes(
      panes: [
        Pane(
          paneConfig: PaneConfig()
              .setPhone(PaneWidth.flexible())
              .setTablet(PaneWidth.flexible())
              .setLaptop(PaneWidth.flexible())
              .setDesktop(PaneWidth.flexible()),
          child: Center(child: Text("Pane 1"),),
          color: Colors.blue,
        ),

        Pane(
          paneConfig: PaneConfig()
              .setPhone(PaneWidth.flexible())
              .setTablet(PaneWidth.flexible())
              .setLaptop(PaneWidth.flexible())
              .setDesktop(PaneWidth.flexible()),
          child: Center(child: Text("${KoiToolbox.windowSize.width} - ${MediaQuery.of(context).size.width}"),),
        ),

        Pane(
          paneConfig: PaneConfig()
              .setPhone(PaneWidth.flexible())
              .setTablet(PaneWidth.flexible())
              .setLaptop(PaneWidth.flexible())
              .setDesktop(PaneWidth.flexible()),
          child: Center(child: Text("Pane 3"),),
        ),
      ],
    );
  }
}


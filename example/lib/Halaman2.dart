import "package:flutter/material.dart";

class Halaman2 extends StatelessWidget {
  const Halaman2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman 2"),),
      body: Center(
        child: ElevatedButton(
          child: Text("Ke halaman 1"),
          onPressed: (){
            Navigator.of(context).pushNamed("/");
          },
        ),
      ),
    );
  }
}

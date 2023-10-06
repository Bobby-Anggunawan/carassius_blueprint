import "package:flutter/material.dart";

class Halaman1 extends StatelessWidget {
  const Halaman1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Halaman 1"),),
      body: Center(
        child: ElevatedButton(
          child: Text("Ke halaman 2"),
          onPressed: (){
            Navigator.of(context).pushNamed("/halaman2");
          },
        ),
      ),
    );
  }
}

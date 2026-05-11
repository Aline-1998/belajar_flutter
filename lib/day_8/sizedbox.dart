import 'package:flutter/material.dart';

class pulu extends StatelessWidget {
  const pulu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("LansCare")),

      body: Column(
        children: [
          Row(children: [Text("PENGUMUMAN")]),
          SizedBox(height: 20),
          Row(children: [Text("Selamat Datang Di Dunia Labubu")]),
        ],
      ),
    );
  }
}

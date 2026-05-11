import 'package:flutter/material.dart';

class LansCare extends StatelessWidget {
  const LansCare({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Labubu"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        //padding: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.only(left: 0.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(children: [Text("Selamat Pagi, Teman-Teman")]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                "Silakan Melakukan Pembayaran Untuk Berlangganan",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Silakan Melakukan Pembayaran Untuk Berlangganan",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                "Silakan Melakukan Pembayaran Untuk Berlangganan",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

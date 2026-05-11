import 'package:flutter/material.dart';

class wops extends StatelessWidget {
  const wops({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("LansCare"),
        backgroundColor: Color.fromARGB(255, 5, 103, 108),
      ),
      //identitas app
      body: Center(
        child: Column(
          children: [
            Text(
              "LansCare",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

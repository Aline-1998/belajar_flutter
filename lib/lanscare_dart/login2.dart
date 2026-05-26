import 'package:flutter/material.dart';

class ConfirmationPage extends StatelessWidget {
  final String nama;
  final String alamat;

  const ConfirmationPage({super.key, required this.nama, required this.alamat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konfirmasi")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            "Terima kasih, $nama dari $alamat telah mendaftar.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

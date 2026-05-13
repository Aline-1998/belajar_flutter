import 'package:flutter/material.dart';

class YuyurYangal extends StatelessWidget {
  const YuyurYangal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Data Pendaftar")),
        backgroundColor: const Color.fromARGB(255, 224, 223, 223),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 234, 234),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Center(
                  child: Text("Biodata Diri", style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 20),

                TextField(
                  decoration: InputDecoration(
                    labelText: "Nama",
                    hintText: "Nama Lengkap",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukan Email",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    labelText: "No. Telp",
                    hintText: "Masukkan Telp",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Alamat",
                    hintText: "Alamat Terkini",
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 234, 234),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Center(
                  child: Text("Nama Member", style: TextStyle(fontSize: 20)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: kontak.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text(kontak[index]["nama"]!),
                      subtitle: Text(kontak[index]["telp"]!),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> kontak = [
  {"nama": "Aline", "telp": "08123456789"},
  {"nama": "Davin", "telp": "08987654321"},
  {"nama": "Wita", "telp": "08234567891"},
  {"nama": "Mala", "telp": "08897654321"},
  {"nama": "Rey", "telp": "087987654321"},
];

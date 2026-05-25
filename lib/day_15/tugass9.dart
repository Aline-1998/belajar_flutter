import 'package:flutter/material.dart';

class Tugass9 extends StatelessWidget {
  const Tugass9({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: const Text("Tugas 9"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.cyan,
                      ),
                      child: Text(
                        "Tugas Level 1",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: alatBantu.length,
                        itemBuilder: (context, index) {
                          return ListTile(title: Text(alatBantu[index]));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.cyan,
                      ),
                      child: Text(
                        "Tugas Level 2",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: jumlahAlat.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(
                              jumlahAlat[index]['icon'],
                              color: Colors.cyan,
                            ),
                            title: Text(jumlahAlat[index]['nama']),
                            subtitle: Text(jumlahAlat[index]['jumlah']),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.cyan,
                      ),
                      child: Text(
                        "Tugas Level 3",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(20),
                        itemCount: fotoKebutuhan.length,
                        itemBuilder: (context, index) {
                          final item = fotoKebutuhan[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(item.pic),
                            ),
                            title: Text(
                              item.name,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text("${item.cloud}"),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> alatBantu = [
  'Timbangan',
  'Pengukur Tensi Darah',
  'Pengukur Tinggi Badan',
  'Makanan Sehat',
  'Snack',
  'Vitamin',
  'Obat',
];
final List<Map<String, dynamic>> jumlahAlat = [
  {'nama': 'Timbangan', 'jumlah': '1', 'icon': Icons.monitor_weight},
  {'nama': 'Pengukur Tensi Darah', 'jumlah': '2', 'icon': Icons.favorite},
  {'nama': 'Pengukur Tinggi Badan', 'jumlah': '1', 'icon': Icons.height},
  {'nama': 'Makanan Sehat', 'jumlah': '100', 'icon': Icons.restaurant},
  {'nama': 'Snack', 'jumlah': '100', 'icon': Icons.fastfood},
  {'nama': 'Vitamin', 'jumlah': '200', 'icon': Icons.medication},
  {'nama': 'Obat', 'jumlah': '700', 'icon': Icons.local_hospital},
];

class KebutuhanPoslan {
  final String name;
  final int cloud;
  final String pic;

  KebutuhanPoslan({required this.name, required this.cloud, required this.pic});

  factory KebutuhanPoslan.fromJson(Map<String, dynamic> json) {
    return KebutuhanPoslan(
      name: json['name'],
      cloud: json['cloud'],
      pic: json['pic'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'name': name, 'cloud': cloud, 'pic': pic};
  }
}

final List<KebutuhanPoslan> fotoKebutuhan = [
  KebutuhanPoslan(
    name: 'Timbangan',
    cloud: 1,
    pic: 'assets/images/timbangan.png',
  ),
  KebutuhanPoslan(
    name: 'Pengukur Tensi Darah',
    cloud: 2,
    pic: 'assets/images/tensi.png',
  ),
  KebutuhanPoslan(
    name: 'Pengukur Tinggi Badan',
    cloud: 1,
    pic: 'assets/images/tb.png',
  ),
  KebutuhanPoslan(
    name: 'Makanan Sehat',
    cloud: 100,
    pic: 'assets/images/makanan.png',
  ),
  KebutuhanPoslan(name: 'Snack', cloud: 100, pic: 'assets/images/snack.png'),
  KebutuhanPoslan(
    name: 'Vitamin',
    cloud: 200,
    pic: 'assets/images/vitamin.png',
  ),
  KebutuhanPoslan(name: 'Obat', cloud: 700, pic: 'assets/images/obat.png'),
];

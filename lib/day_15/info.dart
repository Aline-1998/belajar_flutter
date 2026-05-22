import 'package:flutter/material.dart';

class TentangPage1 extends StatelessWidget {
  const TentangPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),

      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),

              border: Border.all(color: Colors.grey),

              boxShadow: const [
                BoxShadow(blurRadius: 5, color: Colors.black12),
              ],
            ),

            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/images/eren.jpg"),
                    ),

                    Text(
                      "LansCare",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text("Membantu Lansia Sehat"),

                    SizedBox(height: 15),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          "LansCare adalah aplikasi yang dibuat untuk membantu lansia agar tetap hidup sehat",
                        ),

                        SizedBox(height: 15),

                        Text(
                          "Nama Pembuat",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text("Aline Anandya Rizky"),

                        SizedBox(height: 15),

                        Text(
                          "Versi Aplikasi",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text("Version 1.0.0"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LansCareApp extends StatelessWidget {
  const LansCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("REGISTRASI")),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Text("Nama"),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Nama",
                      hintText: "Masukan Nama",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text("Nomor Telp"),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Telp",
                      hintText: "Masukkan Nomor Telp",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text("Email"),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "Masukkan Email",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text("Pasword"),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Pasword",
                      hintText: "Masukkan Pasword",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Text("Konfirmasi Password"),
                  TextField(
                    obscureText: true,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText: "Konfirmasi Pasword",
                      hintText: "Masukkan Konfirmasi Password",
                      filled: true,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.pink),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                  ),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GridView.count(
                    padding: EdgeInsets.only(top: 20),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      contentGrid("assets/images/posyandu1.jpg", "Day 1"),
                      contentGrid("assets/images/posyandu2.jpg", "Day 2"),
                      contentGrid("assets/images/posyandu3.jpeg", "Day 3"),
                      contentGrid("assets/images/posyandu4.jpg", "Day 4"),
                      contentGrid("assets/images/posyandu1.jpg", "Day 1"),
                      contentGrid("assets/images/posyandu2.jpg", "Day 2"),
                      contentGrid("assets/images/posyandu3.jpeg", "Day 3"),
                      contentGrid("assets/images/posyandu4.jpg", "Day 4"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack contentGrid(String imagePath, String postTittle) {
    return Stack(
      alignment: AlignmentGeometry.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(10),
                child: Image.asset(
                  imagePath,
                  height: 122,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 5,
          child: Container(
            color: Colors.lightBlueAccent,
            padding: EdgeInsets.all(5),
            child: Text(
              postTittle,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

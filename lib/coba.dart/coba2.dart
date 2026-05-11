import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Color cyanGreen = const Color.fromARGB(255, 5, 103, 108);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cyanGreen,
        elevation: 0,
        title: const Text(
          "LansCares",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cyanGreen, Colors.cyan.shade200],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color.fromARGB(255, 5, 103, 108),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Jhovin Dasilva",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Anggota LansCare",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DETAIL KONTAK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email, color: cyanGreen),
                        const SizedBox(width: 10),
                        const Text(
                          "davin@gmail.com",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Icon(Icons.phone, color: cyanGreen),
                        const SizedBox(width: 10),
                        const Text(
                          "0822-1020-2324",
                          style: TextStyle(fontSize: 16),
                        ),

                        const Spacer(),

                        const Icon(Icons.location_on),
                        const SizedBox(width: 5),
                        const Text("Jakarta"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // STATISTIK
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        children: const [
                          Icon(
                            Icons.favorite,
                            color: Color(0xFF00B8A9),
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "12",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Pemeriksaan"),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Column(
                        children: const [
                          Icon(
                            Icons.calendar_month,
                            color: Color(0xFF00B8A9),
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "5",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Jadwal"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // DESKRIPSI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: const Text(
                  "Jhovin Dasilva adalah anggota aktif LansCare yang rutin mengikuti pemeriksaan kesehatan dan kegiatan posyandu lansia setiap bulan.",
                  style: TextStyle(fontSize: 16, height: 1.5),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // VISUAL BRANDING
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 150,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),

                  image: const DecorationImage(
                    image: AssetImage("assets/images/posyandu lansia.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

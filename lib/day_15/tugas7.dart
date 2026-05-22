import 'package:flutter/material.dart';

class Tugasinput extends StatelessWidget {
  const Tugasinput({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isChecked = false;
  bool isDarkMode = false;

  String selectedKategori = "Timbangan";

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Color backgroundColor = Colors.white;

  Future<void> pilihTanggal() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pilihWaktu() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(title: const Text("Home"), backgroundColor: Colors.blue),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/eren.jpg"),
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text("Mode Tampilan"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.category),
              title: const Text("Kategori Produk"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text("Pilih Tanggal"),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Atur Pengingat"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // =========================
            // 1. SYARAT & KETENTUAN
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Syarat & Ketentuan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  CheckboxListTile(
                    value: isChecked,

                    title: const Text("Saya menyetujui persyaratan"),

                    onChanged: (value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),

                  Text(
                    isChecked
                        ? "Pendaftaran diperbolehkan"
                        : "Pendaftaran belum tersedia",

                    style: TextStyle(
                      fontSize: 16,
                      color: isChecked
                          ? const Color.fromARGB(255, 76, 129, 175)
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            // =========================
            // 2. MODE TAMPILAN
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mode Tampilan",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  SwitchListTile(
                    value: isDarkMode,

                    title: const Text("Aktifkan Mode Gelap"),

                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;

                        backgroundColor = value
                            ? Colors.grey.shade900
                            : Colors.white;
                      });
                    },
                  ),

                  Text(isDarkMode ? "Mode Gelap Aktif" : "Mode Terang Aktif"),
                ],
              ),
            ),

            // =========================
            // 3. KATEGORI PRODUK
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Produk",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    initialValue: selectedKategori,

                    items: const [
                      DropdownMenuItem(
                        value: "Timbangan",
                        child: Text("Timbangan"),
                      ),

                      DropdownMenuItem(value: "Snack", child: Text("Snack")),

                      DropdownMenuItem(
                        value: "Tensi Darah",
                        child: Text("Tensi Darah"),
                      ),

                      DropdownMenuItem(
                        value: "Lainnya",
                        child: Text("Lainnya"),
                      ),
                    ],

                    onChanged: (value) {
                      setState(() {
                        selectedKategori = value!;
                      });
                    },
                  ),

                  const SizedBox(height: 10),

                  Text("Anda memilih kategori: $selectedKategori"),
                ],
              ),
            ),

            // =========================
            // 4. PILIH TANGGAL
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tanggal",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: pilihTanggal,
                    child: const Text("Tanggal"),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    selectedDate == null
                        ? "Tanggal Lahir: -"
                        : "Tanggal Lahir: "
                              "${selectedDate!.day.toString().padLeft(2, '0')}-"
                              "${selectedDate!.month.toString().padLeft(2, '0')}-"
                              "${selectedDate!.year}",
                  ),
                ],
              ),
            ),

            // =========================
            // 5. ATUR PENGINGAT
            // =========================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
                boxShadow: const [
                  BoxShadow(blurRadius: 5, color: Colors.black12),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alarm Pengingat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: pilihWaktu,
                    child: const Text("Alarm Pengingat"),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    selectedTime == null
                        ? "Pengingat diatur pukul: -"
                        : "Pengingat diatur pukul: "
                              "${selectedTime!.hour.toString().padLeft(2, '0')}:"
                              "${selectedTime!.minute.toString().padLeft(2, '0')}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

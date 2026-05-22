import 'package:belajar_flutter/day_10/tugas3.dart';
import 'package:belajar_flutter/day_10/tugas4.dart';
import 'package:belajar_flutter/extension/navigator.dart';
import 'package:flutter/material.dart';

class Tugas7 extends StatelessWidget {
  const Tugas7({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drawer',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const HomePage(),
    );
  }
}

/// =======================================================
/// HOME PAGE
/// =======================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// CHECKBOX
  bool isChecked = false;

  /// SWITCH
  bool isDarkMode = false;

  /// DROPDOWN
  String selectedCategory = "Timbangan";

  /// DATE
  DateTime? selectedDate;

  /// TIME
  TimeOfDay? selectedTime;

  /// ==============================
  /// DATE PICKER
  /// ==============================

  Future<void> pickDate() async {
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

  /// ==============================
  /// TIME PICKER
  /// ==============================

  Future<void> pickTime() async {
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
    final backgroundColor = isDarkMode
        ? const Color(0xFF111111)
        : const Color(0xFFF5F5F5);

    final cardColor = isDarkMode ? const Color(0xFF1C1C1C) : Colors.white;

    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,

      /// APPBAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Home",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),

      /// ===================================================
      /// DRAWER
      /// ===================================================
      drawer: Drawer(
        backgroundColor: const Color(0xFF111111),

        child: Column(
          children: [
            /// HEADER
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage("assets/images/eren.jpg"),
                  ),

                  const Spacer(),

                  Center(
                    child: const Text(
                      "Profile",

                      style: TextStyle(
                        color: Colors.white,

                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Aline Anandya Rizky",
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),

            /// MENU
            drawerMenu(
              icon: Icons.dashboard,
              title: "Dashboard",
              halamanTujuan: LansCare(),
            ),

            drawerMenu(
              icon: Icons.analytics,
              title: "Kurva Kesehatan",
              halamanTujuan: YuyurYangal(),
            ),

            drawerMenu(
              icon: Icons.inventory,
              title: "Barang",
              halamanTujuan: LansCare(),
            ),

            drawerMenu(
              icon: Icons.settings,
              title: "Pengaturan",
              halamanTujuan: YuyurYangal(),
            ),

            drawerMenu(
              icon: Icons.logout,
              title: "Keluar",
              halamanTujuan: LansCare(),
            ),
          ],
        ),
      ),

      /// BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// HEADER TEXT
            // Text(
            //   "Interactive Input Form",

            //   style: TextStyle(
            //     color: textColor,

            //     fontSize: 28,

            //     fontWeight: FontWeight.bold,
            //   ),
            // ),

            // const SizedBox(height: 8),

            // Text(
            //   "Kelola bisnis UMKM dengan tampilan modern dan premium.",

            //   style: TextStyle(
            //     color: isDarkMode ? Colors.white70 : Colors.black54,

            //     height: 1.5,
            //   ),
            // ),

            // const SizedBox(height: 30),

            /// =============================================
            /// CHECKBOX CARD
            /// =============================================
            buildCard(
              cardColor: cardColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  sectionTitle("Syarat & Ketentuan", textColor),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,

                        activeColor: Colors.black,

                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),

                      Expanded(
                        child: Text(
                          "Saya menyetujui persyaratan",

                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: isChecked
                          ? Colors.green.shade100
                          : Colors.red.shade100,

                      borderRadius: BorderRadius.circular(18),
                    ),

                    child: Text(
                      isChecked
                          ? "Pendaftaran diperbolehkan"
                          : "Pendaftaran belum tersedia",

                      style: TextStyle(
                        color: Colors.black,

                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// =============================================
            /// SWITCH CARD
            /// =============================================
            Center(
              child: buildCard(
                cardColor: cardColor,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    sectionTitle("Mode Tampilan", textColor),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(
                          "Aktifkan Mode Gelap",

                          style: TextStyle(
                            color: textColor,

                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        Switch(
                          value: isDarkMode,

                          activeThumbColor: Colors.black,

                          onChanged: (value) {
                            setState(() {
                              isDarkMode = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// =============================================
            /// DROPDOWN CARD
            /// =============================================
            buildCard(
              cardColor: cardColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  sectionTitle("Produk", textColor),

                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),

                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white10 : Colors.grey.shade100,

                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: DropdownButton(
                      dropdownColor: isDarkMode ? Colors.black : Colors.white,

                      value: selectedCategory,

                      isExpanded: true,

                      underline: const SizedBox(),

                      style: TextStyle(color: textColor),

                      items: const [
                        DropdownMenuItem(
                          value: "Timbangan",

                          child: Text("Timbangan"),
                        ),

                        DropdownMenuItem(
                          value: "Tensi Darah",

                          child: Text("Tensi Darah"),
                        ),

                        DropdownMenuItem(
                          value: "Makanan",

                          child: Text("Makanan"),
                        ),

                        DropdownMenuItem(
                          value: "Lainnya",

                          child: Text("Lainnya"),
                        ),
                      ],

                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value!;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "Anda memilih kategori: $selectedCategory",

                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// =============================================
            /// DATE PICKER
            /// =============================================
            buildCard(
              cardColor: cardColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  sectionTitle("Pilih Tanggal", textColor),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: pickDate,

                      child: const Text(
                        "Pilih Tanggal",

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    selectedDate == null
                        ? "Belum memilih tanggal"
                        : "Tanggal Lahir: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",

                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            /// =============================================
            /// TIME PICKER
            /// =============================================
            buildCard(
              cardColor: cardColor,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  sectionTitle("Atur Pengingat", textColor),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,

                    height: 55,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),

                      onPressed: pickTime,

                      child: const Text(
                        "Atur Waktu",

                        style: TextStyle(
                          color: Colors.white,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    selectedTime == null
                        ? "Belum mengatur waktu"
                        : "Pengingat diatur pukul: ${selectedTime!.format(context)}",

                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// =======================================================
  /// DRAWER MENU
  /// =======================================================

  Widget drawerMenu({
    required IconData icon,
    required String title,
    required Widget halamanTujuan,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),

      title: Text(title, style: const TextStyle(color: Colors.white)),

      onTap: () {
        context.push(halamanTujuan);
      },
    );
  }

  /// =======================================================
  /// CARD
  /// =======================================================

  Widget buildCard({required Widget child, required Color cardColor}) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: cardColor,

        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),

            blurRadius: 20,

            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: child,
    );
  }

  /// =======================================================
  /// TITLE
  /// =======================================================

  Widget sectionTitle(String title, Color textColor) {
    return Text(
      title,

      style: TextStyle(
        color: textColor,

        fontSize: 18,

        fontWeight: FontWeight.bold,
      ),
    );
  }
}

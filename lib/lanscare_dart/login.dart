import 'package:belajar_flutter/lanscare_dart/login2.dart';
import 'package:flutter/material.dart';

class LansCareApp1 extends StatelessWidget {
  const LansCareApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LansCare',
      theme: ThemeData(primaryColor: const Color(0xFF0097A7)),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController paswordController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();
  final TextEditingController telpController = TextEditingController();

  void showDataDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(15),
          ),

          // backgroundColor: Color(0xFF0097A7),
          title: const Text(
            "Konfirmasi Data",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nama Lengkap: ${namaController.text}"),
              Text("Alamat Lengkap : ${alamatController.text}"),
              Text("Nik : ${nikController.text}"),
              Text("Email : ${emailController.text}"),
              Text("No. Telpon : ${telpController.text}"),
              Text("Tempat Tanggal Lahir : ${ttlController.text}"),
              Text("Pasword : ${paswordController.text}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Batal", style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0097A7),
              ),
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationPage(
                      nama: namaController.text,
                      alamat: alamatController.text,
                    ),
                  ),
                );
              },
              child: const Text(
                "Lanjut",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    telpController.dispose();
    ttlController.dispose();
    nikController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color cyanGreen = const Color(0xFF0097A7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),

              child: Column(
                children: [
                  // Logo
                  const SizedBox(height: 20),

                  CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.cyan.shade50,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 75,
                          backgroundImage: AssetImage(
                            "assets/images/logo poslan.png",
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Judul
                  Text(
                    "LANSCARE",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: cyanGreen,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "Sehat Bersama, Bahagia Selalu",
                    style: TextStyle(fontSize: 25, color: Colors.black54),
                  ),

                  const SizedBox(height: 35),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: namaController,
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap",
                            hintText: "Masukan Nama Lengkap",
                            prefixIcon: const Icon(Icons.perm_identity),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama Lengkap";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        //No kk
                        // TextFormField(
                        //   decoration: InputDecoration(
                        //     labelText: "No. kk",
                        //     hintText: "Masukan No. Kartu Keluarga",
                        //     prefixIcon: const Icon(Icons.family_restroom),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return "No. kk ";
                        //     }
                        //     return null;
                        //   },
                        // ),
                        // const SizedBox(height: 15),

                        // nik
                        TextFormField(
                          controller: nikController,
                          decoration: InputDecoration(
                            labelText: "Nik",
                            hintText: "Masukan Nik",
                            prefixIcon: const Icon(Icons.perm_identity),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nik";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: alamatController,
                          decoration: InputDecoration(
                            labelText: "Alamat Lengkap",
                            hintText: "Masukan Alamat Lengkap",
                            prefixIcon: const Icon(Icons.family_restroom),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Alamat Lengkap";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),

                        //Tempat Tanggal Lahir
                        TextField(
                          controller: ttlController,
                          decoration: InputDecoration(
                            labelText: "Tempat Tanggal Lahir",
                            hintText: "Masukan Tempat Tanggal Lahir",
                            prefixIcon: const Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        //No Telp
                        TextField(
                          controller: telpController,
                          decoration: InputDecoration(
                            labelText: "No. Telpon (Opsional)",
                            hintText: "Masukan No. Telp",
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        // Email
                        // Form(
                        //   key: _formKey,
                        //   child: Column(
                        //     children: [
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: "LansCare@gmail.com",
                            hintStyle: TextStyle(fontSize: 20),
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "masukan email";
                            } else if (!value.contains('@')) {
                              return "Format email tidak valid";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        // Password
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: "*",
                          controller: paswordController,
                          decoration: InputDecoration(
                            labelText: "Pasword",
                            labelStyle: TextStyle(fontSize: 20),
                            hintText: "Masukan Pasword",
                            hintStyle: TextStyle(fontSize: 20),
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "masukan pasword";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cyanGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                showDataDialog();
                              }
                            },

                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        const Text(
                          "atau",
                          style: TextStyle(fontSize: 20, color: Colors.black54),
                        ),

                        const SizedBox(height: 15),

                        // Tombol Kader
                        SizedBox(
                          width: double.infinity,
                          height: 50,

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: cyanGreen),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),

                            onPressed: () {},

                            child: Text(
                              "Masuk sebagai Kader",
                              style: TextStyle(fontSize: 20, color: cyanGreen),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Belum punya akun? ",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                              ),
                            ),

                            Text(
                              "Daftar",
                              style: TextStyle(
                                fontSize: 20,
                                color: cyanGreen,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LansCareApp1 extends StatelessWidget {
  const LansCareApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LansCare',
      theme: ThemeData(primaryColor: const Color(0xFF0097A7)),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
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

                  // //No kk
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: "No. kk",
                  //     hintText: "Masukan No. Kartu Keluarga",
                  //     prefixIcon: const Icon(Icons.family_restroom),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),

                  // // nik
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: "Nik",
                  //     hintText: "Masukan Nik",
                  //     prefixIcon: const Icon(Icons.perm_identity),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),

                  // //Tempat Tanggal Lahir
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: "Tempat Tanggal Lahir",
                  //     hintText: "Masukan Tempat Tanggal Lahir",
                  //     prefixIcon: const Icon(Icons.calendar_month),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 15),

                  // //No Telp
                  // TextField(
                  //   decoration: InputDecoration(
                  //     hintText: "No Telp",
                  //     prefixIcon: const Icon(Icons.email_outlined),
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(12),
                  //     ),
                  //   ),
                  // ),

                  // const SizedBox(height: 15),

                  // Email
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
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
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        // Password
                        TextFormField(
                          obscureText: true,
                          obscuringCharacter: "*",

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
                        const SizedBox(height: 15),

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
                                print("berhasil login");
                              } else {
                                print("eror");
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

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

                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     "Lupa password?",
                  //     style: TextStyle(fontSize: 25, color: cyanGreen),
                  //   ),
                  // ),

                  // SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum punya akun? ",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
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
          ),
        ),
      ),
    );
  }
}

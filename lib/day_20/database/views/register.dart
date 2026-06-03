import 'package:belajar_flutter/day_20/database/db_helper.dart';
import 'package:belajar_flutter/day_20/database/model/user_models_sql.dart';
import 'package:belajar_flutter/day_20/database/views/login.dart';
import 'package:belajar_flutter/extension/navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreenDay20 extends StatefulWidget {
  const RegisterScreenDay20({super.key});

  @override
  State<RegisterScreenDay20> createState() => _RegisterScreenDay20State();
}

class _RegisterScreenDay20State extends State<RegisterScreenDay20> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController paswordController = TextEditingController();
  final TextEditingController nikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController ttlController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  void register() async {
    final email = emailController.text.trim();
    final nama = namaController.text.trim();
    final pass = paswordController.text;
    final nik = nikController.text.trim();
    final alamat = alamatController.text.trim();
    final ttl = ttlController.text.trim();
    final telp = telpController.text.trim();

    if (email.isEmpty ||
        pass.isEmpty ||
        nama.isEmpty ||
        nik.isEmpty ||
        alamat.isEmpty ||
        ttl.isEmpty ||
        telp.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('isi semua data')));
      return;
    }
    final user = UserModelSql(
      nama: nama,
      nik: nik,
      alamat: alamat,
      ttl: ttl,
      email: email,
      password: pass,
    );
    bool success = await DBHelper().registerUser(user);
    // Cek apakah widget masih terpasang (mounted) sebelum menggunakan context
    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Akun Berhasil dibuat')));
      context.push(LoginPage22());
    }
    // Tambahkan navigasi ke halaman login jika perlu
    else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email sudah digunakan!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cyanGreen = const Color(0xFF0097A7);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),

            child: SingleChildScrollView(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textTitleForm("Nama Lengkap"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: namaController,
                          hintText: "Masukkan Nama",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        textTitleForm("Alamat Lengkap"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: alamatController,
                          hintText: "Masukkan Alamat",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Alamat tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        textTitleForm("No. Telp"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: telpController,
                          hintText: "Masukkan No. Telp",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "No. Telp tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        textTitleForm("Tempat Tanggal Lahir"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: ttlController,
                          hintText: "Masukkan Ttl",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ttl tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),
                        textTitleForm("Nik"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: nikController,
                          hintText: "Masukkan Nik",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nik tidak boleh kosong";
                            } else if (value.length != 16) {
                              return "Nik harus 16 digit";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24),
                        textTitleForm("Email"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong";
                            } else if (!value.contains('@')) {
                              return "Format email tidak valid";
                            }
                            return null;
                          },
                          hintText: "Masukkan Email",
                        ),
                        SizedBox(height: 24),

                        textTitleForm("Password"),
                        SizedBox(height: 12),

                        textFormConst(
                          controller: paswordController,
                          hintText: "Masukkan Password",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password tidak boleh kosong";
                            } else if (value.length < 6) {
                              return "Password terlalu singkat";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Remember Me",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueGrey,
                              ),
                            ),
                            Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),

                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Colors.blueAccent,
                            ),
                            onPressed: register,
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Text.rich(
                          TextSpan(
                            text: "Have an account? ",
                            style: TextStyle(color: Colors.blueGrey),
                            children: [
                              TextSpan(
                                text: "Sign In",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.push(LoginPage22()),
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
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

  TextFormField textFormConst({
    required String hintText,
    required String? Function(String?)? validator,
    required TextEditingController controller,
  }) {
    return TextFormField(
      onChanged: (value) {
        setState(() {});
      },
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: borderConst(),
        focusedBorder: borderConst(),
        border: borderConst(),
      ),
    );
  }

  OutlineInputBorder borderConst() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.blueGrey),
    );
  }

  Widget textTitleForm(String text) => Row(
    children: [
      Text(text, style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
    ],
  );
}

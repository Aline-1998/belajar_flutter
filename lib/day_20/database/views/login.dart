import 'package:belajar_flutter/day_20/database/db_helper.dart';
import 'package:belajar_flutter/day_20/database/model/user_models_sql.dart';
import 'package:belajar_flutter/day_20/database/views/home.dart';
import 'package:belajar_flutter/day_20/database/views/register.dart';
import 'package:belajar_flutter/extension/navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage22 extends StatefulWidget {
  const LoginPage22({super.key});

  @override
  State<LoginPage22> createState() => _LoginPage22State();
}

class _LoginPage22State extends State<LoginPage22> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController paswordController = TextEditingController();

  void login() async {
    final email = emailController.text.trim();
    final pass = paswordController.text;

    if (email.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('isi semua data')));
      return;
    }
    final pengguna = await DBHelper().loginUser(
      LoginModel(email: email, password: pass),
    );
    // Cek apakah widget masih terpasang (mounted) sebelum menggunakan context
    if (!mounted) return;

    if (pengguna != null) {
      context.pushAndRemoveAll(HomePageModel());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! email atau Password salah.'),
        ),
      );
    }
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                color: Colors.blueAccent,
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
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: login,

                            child: Text(
                              "Log In",
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
                            text: "Don’t have an account? ",

                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: "Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      context.push(RegisterScreenDay20()),
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

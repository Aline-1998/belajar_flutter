import 'package:belajar_flutter/day_20/database/db_helper.dart';
import 'package:belajar_flutter/day_20/database/model/user_models_sql.dart';
import 'package:belajar_flutter/extension/navigator.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_viewer2/sqlite_viewer.dart';

class HomePageModel extends StatefulWidget {
  const HomePageModel({super.key});

  @override
  State<HomePageModel> createState() => _HomePageModelState();
}

class _HomePageModelState extends State<HomePageModel> {
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
      setState(() {});
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "LansCare",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pendataan", style: TextStyle(fontSize: 20)),
                      SizedBox(height: 20),
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
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<UserModelSql>>(
                future: DBHelper().getAllUsers(),
                builder: (context, snapshot) {
                  // Menampilkan indikator loading saat menunggu data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Menangani jika terjadi error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Terjadi kesalahan: ${snapshot.error}'),
                    );
                  }

                  // Menangani jika data kosong atau tidak ada data
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada data pengguna.'),
                    );
                  }

                  // Jika data berhasil didapatkan
                  final daftarPengguna = snapshot.data!;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: daftarPengguna.length,
                    itemBuilder: (context, index) {
                      final user = daftarPengguna[index];
                      return Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                          title: Text(user.email),
                          subtitle: Text('Password: ${user.password}'),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.edit_document,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () => _showBottomSheet(context, user),
                          ),
                          onTap: () => _showBottomSheet(context, user),
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                width: double.infinity,
                child: DefaultButton(
                  text: "Lihat Database",

                  onPressed: () {
                    context.push(DatabaseList());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, UserModelSql user) {
    final emailController = TextEditingController(text: user.email);
    final passwordController = TextEditingController(text: user.password);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Kelola Pengguna',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Row untuk Tombol Update dan Delete
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Tombol Update
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (user.id != null) {
                        final updatedUser = UserModelSql(
                          id: user.id,
                          nama: namaController.text.trim(),
                          nik: nikController.text.trim(),
                          ttl: ttlController.text.trim(),
                          alamat: alamatController.text.trim(),
                          telp: telpController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text,
                        );
                        bool success = await DBHelper().updateUser(updatedUser);
                        if (success && context.mounted) {
                          Navigator.pop(context);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data berhasil diperbarui'),
                            ),
                          );
                        }
                      }
                    },
                  ),

                  // Tombol Delete
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (user.id != null) {
                        await DBHelper().deleteUser(user.id!);
                        if (context.mounted) {
                          Navigator.pop(context);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Data berhasil dihapus'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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
      borderSide: BorderSide(color: Colors.grey),
    );
  }

  Widget textTitleForm(String text) => Row(
    children: [
      Text(text, style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
    ],
  );
}

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const DefaultButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1A2E44),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lanscare_app/tugas15/service/auth_service.dart';
import 'package:lanscare_app/tugas15/service/dio.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  late final AuthService _authService;
  Future<Map<String, dynamic>>? _usersFuture;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _authService = AuthService(dio);
    _loadUsers();
  }

  void _loadUsers() {
    setState(() {
      _usersFuture = _authService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Daftar Pengguna", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF38BDF8)),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 64, color: Colors.redAccent),
                      const SizedBox(height: 16),
                      Text(
                        "Gagal memuat daftar pengguna: ${snapshot.error}",
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)),
                        onPressed: _loadUsers,
                        child: const Text("Coba Lagi", style: TextStyle(color: Color(0xFF0F172A))),
                      ),
                    ],
                  ),
                ),
              );
            }

            final responseData = snapshot.data;
            final usersList = responseData?['data'] as List<dynamic>? ?? [];

            if (usersList.isEmpty) {
              return const Center(
                child: Text("Tidak ada pengguna terdaftar", style: TextStyle(color: Colors.white)),
              );
            }

            return RefreshIndicator(
              color: const Color(0xFF38BDF8),
              backgroundColor: const Color(0xFF1E293B),
              onRefresh: () async => _loadUsers(),
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: usersList.length,
                itemBuilder: (context, index) {
                  final user = usersList[index];
                  final profilePhoto = user['profile_photo'] as String?;
                  final name = user['name'] as String? ?? "Tanpa Nama";
                  final email = user['email'] as String? ?? "-";
                  final role = user['role'] as String? ?? "User";
                  final gender = user['jenis_kelamin'] == "L" ? "Laki-laki" : (user['jenis_kelamin'] == "P" ? "Perempuan" : "-");

                  return Card(
                    color: const Color(0xFF1E293B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: const BorderSide(color: Color(0xFF334155)),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        radius: 26,
                        backgroundColor: const Color(0xFF38BDF8),
                        backgroundImage: profilePhoto != null && profilePhoto.isNotEmpty
                            ? NetworkImage(profilePhoto)
                            : null,
                        child: profilePhoto == null || profilePhoto.isEmpty
                            ? const Icon(Icons.person, color: Colors.white, size: 26)
                            : null,
                      ),
                      title: Text(
                        name,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(email, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF38BDF8).withAlpha(30),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    role.toUpperCase(),
                                    style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  gender,
                                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

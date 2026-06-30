import 'package:flutter/material.dart';
import 'package:lanscare_app/tugas15/model/user_model.dart';
import 'package:lanscare_app/tugas15/service/auth_service.dart';
import 'package:lanscare_app/tugas15/service/dio.dart';
import 'package:lanscare_app/tugas15/service/token_storage.dart';
import 'package:lanscare_app/tugas15/views/login_view.dart';
import 'package:lanscare_app/tugas15/views/edit_profile_view.dart';
import 'package:lanscare_app/tugas15/views/edit_photo_view.dart';
import 'package:lanscare_app/tugas15/views/users_list_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final AuthService _authService;
  Future<UserModel?>? _profileFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _authService = AuthService(dio);
    _loadProfile();
  }

  void _loadProfile() {
    setState(() {
      _profileFuture = _fetchProfileData();
    });
  }

  Future<UserModel?> _fetchProfileData() async {
    try {
      final response = await _authService.getProfile();
      return response.data;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal memuat profil: $e"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      return null;
    }
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);
    try {
      await TokenStorage.deleteToken();
      if (mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal Logout: $e")),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _navigateToEditProfile(String currentName) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileView(currentName: currentName),
      ),
    );
    if (result == true) {
      _loadProfile();
    }
  }

  Future<void> _navigateToEditPhoto(String? currentPhotoUrl) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPhotoView(currentPhotoUrl: currentPhotoUrl),
      ),
    );
    if (result == true) {
      _loadProfile();
    }
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF334155), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF38BDF8), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text("Dashboard Profil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outline_rounded, color: Color(0xFF38BDF8)),
            tooltip: "Daftar Pengguna",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersListView()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            tooltip: "Keluar",
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<UserModel?>(
              future: _profileFuture,
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
                            "Error: ${snapshot.error}",
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)),
                            onPressed: _loadProfile,
                            child: const Text("Coba Lagi", style: TextStyle(color: Color(0xFF0F172A))),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final user = snapshot.data;
                if (user == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Data profil tidak ditemukan", style: TextStyle(color: Colors.white)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF38BDF8)),
                          onPressed: _loadProfile,
                          child: const Text("Refresh", style: TextStyle(color: Color(0xFF0F172A))),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: const Color(0xFF38BDF8),
                  backgroundColor: const Color(0xFF1E293B),
                  onRefresh: () async {
                    _loadProfile();
                    await _profileFuture;
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Profile Photo View/Edit
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor: const Color(0xFF38BDF8),
                                child: CircleAvatar(
                                  radius: 62,
                                  backgroundColor: const Color(0xFF1E293B),
                                  backgroundImage: user.profilePhoto != null && user.profilePhoto!.isNotEmpty
                                      ? NetworkImage(user.profilePhoto!)
                                      : null,
                                  child: user.profilePhoto == null || user.profilePhoto!.isEmpty
                                      ? const Icon(Icons.person, size: 65, color: Color(0xFF94A3B8))
                                      : null,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => _navigateToEditPhoto(user.profilePhoto),
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF38BDF8),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.camera_alt,
                                      size: 20,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Name Card
                        Card(
                          color: const Color(0xFF1E293B),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(color: Color(0xFF334155)),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                            title: const Text(
                              "Nama Lengkap",
                              style: TextStyle(
                                color: Color(0xFF38BDF8),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                user.name ?? "-",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit_outlined, color: Color(0xFF38BDF8)),
                              onPressed: () => _navigateToEditProfile(user.name ?? ""),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        
                        // Info fields
                        _buildInfoTile("Email Address", user.email ?? "-", Icons.email_outlined),
                        _buildInfoTile("Jenis Kelamin", user.jenisKelamin == "L" ? "Laki-laki" : (user.jenisKelamin == "P" ? "Perempuan" : "-"), Icons.wc_outlined),
                        _buildInfoTile("Role", user.role ?? "-", Icons.admin_panel_settings_outlined),
                        _buildInfoTile("Status Akun", user.isActive == "1" ? "Active" : "Inactive", Icons.check_circle_outline),
                        if (user.batch != null)
                          _buildInfoTile("Batch", "Batch ${user.batch?.batchKe ?? "-"}", Icons.badge_outlined),
                        if (user.training != null)
                          _buildInfoTile("Training Class", user.training?.title ?? "-", Icons.model_training_outlined),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withAlpha(128),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF38BDF8)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lanscare_app/tugas15/service/auth_service.dart';
import 'package:lanscare_app/tugas15/service/dio.dart';
import 'package:lanscare_app/tugas15/service/token_storage.dart';
import 'package:lanscare_app/tugas15/views/profile_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _selectedBatchId;
  String? _selectedTrainingId;
  String _selectedGender = "L"; // L = Laki-laki, P = Perempuan

  List<dynamic> _batches = [];
  List<dynamic> _trainings = [];

  String? _base64Photo;
  File? _pickedImageFile;
  bool _obscurePassword = true;

  late final AuthService _authService;
  bool _isLoading = false;
  bool _isFetchingMetaData = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    final dio = createDioClient();
    _authService = AuthService(dio);
    _loadMetaData();
  }

  Future<void> _loadMetaData() async {
    try {
      final batchesData = await _authService.getBatches();
      final trainingsData = await _authService.getTrainings();

      setState(() {
        _batches = batchesData['data'] ?? [];
        _trainings = trainingsData['data'] ?? [];

        if (_batches.isNotEmpty) {
          _selectedBatchId = _batches.first['id']?.toString();
        }
        if (_trainings.isNotEmpty) {
          _selectedTrainingId = _trainings.first['id']?.toString();
        }
        _isFetchingMetaData = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Gagal memuat data angkatan/kelas: $e";
        _isFetchingMetaData = false;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        final bytes = await File(pickedFile.path).readAsBytes();
        final extension = pickedFile.path.split('.').last.toLowerCase();
        final mimeType = extension == 'png' ? 'image/png' : 'image/jpeg';
        setState(() {
          _pickedImageFile = File(pickedFile.path);
          _base64Photo = "data:$mimeType;base64,${base64Encode(bytes)}";
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Gagal mengambil gambar: $e")));
      }
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final requestBody = {
        "name": _nameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
        "jenis_kelamin": _selectedGender,
        "batch_id": _selectedBatchId,
        "training_id": _selectedTrainingId,
      };

      if (_base64Photo != null) {
        requestBody["profile_photo"] = _base64Photo!;
      } else {
        requestBody["profile_photo"] = "";
      }

      final response = await _authService.register(requestBody);
      final token = response.data?.token;

      if (token != null) {
        await TokenStorage.saveToken(token);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrasi Berhasil!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileView()),
            (route) => false,
          );
        }
      } else {
        setState(() {
          _errorMessage = response.message ?? "Registrasi gagal";
        });
      }
    } catch (e) {
      String errMsg = "Registrasi gagal: $e";
      if (e is DioException) {
        final responseData = e.response?.data;
        if (responseData is Map && responseData.containsKey('message')) {
          errMsg = responseData['message'] ?? errMsg;
          if (responseData.containsKey('errors')) {
            final errors = responseData['errors'];
            if (errors is Map) {
              final errorList = [];
              errors.forEach((key, val) {
                if (val is List) {
                  errorList.addAll(val);
                } else {
                  errorList.add(val.toString());
                }
              });
              if (errorList.isNotEmpty) {
                errMsg = "$errMsg\n${errorList.join('\n')}";
              }
            }
          }
        }
      }
      setState(() {
        _errorMessage = errMsg;
      });
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: const Color(0xFF94A3B8)),
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF94A3B8)),
      filled: true,
      fillColor: const Color(0xFF1E293B),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF334155)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF38BDF8), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text(
          "Create Account",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _isFetchingMetaData
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Color(0xFF38BDF8)),
                        SizedBox(height: 16),
                        Text(
                          "Memuat data angkatan & kelas...",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Photo Picker
                          Center(
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 55,
                                    backgroundColor: const Color(0xFF38BDF8),
                                    child: CircleAvatar(
                                      radius: 52,
                                      backgroundColor: const Color(0xFF1E293B),
                                      backgroundImage: _pickedImageFile != null
                                          ? FileImage(_pickedImageFile!)
                                          : null,
                                      child: _pickedImageFile == null
                                          ? const Icon(
                                              Icons.add_a_photo,
                                              size: 36,
                                              color: Color(0xFF38BDF8),
                                            )
                                          : null,
                                    ),
                                  ),
                                  if (_pickedImageFile != null)
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF38BDF8),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                          color: Color(0xFF0F172A),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (_errorMessage != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.withAlpha(26),
                                border: Border.all(color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: Colors.redAccent),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          // Name Field
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              "Full Name",
                              Icons.person_outline,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Nama tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Email Field
                          TextFormField(
                            controller: _emailController,
                            style: const TextStyle(color: Colors.white),
                            keyboardType: TextInputType.emailAddress,
                            decoration: _inputDecoration(
                              "Email Address",
                              Icons.email_outlined,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email tidak boleh kosong";
                              }
                              final emailRegex = RegExp(
                                r'^[^@]+@[^@]+\.[^@]+$',
                              );
                              if (!emailRegex.hasMatch(value.trim())) {
                                return "Format email tidak valid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Password Field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              "Password",
                              Icons.lock_outline,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFF94A3B8),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                              if (value.length < 6) {
                                return "Password minimal 6 karakter";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          // Gender Dropdown (L / P)
                          DropdownButtonFormField<String>(
                            initialValue: _selectedGender,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              "Gender",
                              Icons.wc_outlined,
                            ),
                            items: const [
                              DropdownMenuItem<String>(
                                value: "L",
                                child: Text("Laki-laki"),
                              ),
                              DropdownMenuItem<String>(
                                value: "P",
                                child: Text("Perempuan"),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedGender = val);
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          // Dynamic Batch Dropdown
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _selectedBatchId,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              "Batch / Angkatan",
                              Icons.badge_outlined,
                            ),
                            items: _batches.map<DropdownMenuItem<String>>((
                              batch,
                            ) {
                              return DropdownMenuItem<String>(
                                value: batch['id']?.toString(),
                                child: Text(
                                  "Batch ${batch['batch_ke'] ?? batch['id']}",
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedBatchId = val);
                              }
                            },
                            validator: (value) =>
                                value == null ? "Pilih angkatan" : null,
                          ),
                          const SizedBox(height: 16),
                          // Dynamic Training Dropdown
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            initialValue: _selectedTrainingId,
                            dropdownColor: const Color(0xFF1E293B),
                            style: const TextStyle(color: Colors.white),
                            decoration: _inputDecoration(
                              "Kelas Pelatihan",
                              Icons.model_training_outlined,
                            ),
                            items: _trainings.map<DropdownMenuItem<String>>((
                              training,
                            ) {
                              return DropdownMenuItem<String>(
                                value: training['id']?.toString(),
                                child: Text(
                                  training['title'] ??
                                      "Training ${training['id']}",
                                ),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _selectedTrainingId = val);
                              }
                            },
                            validator: (value) =>
                                value == null ? "Pilih kelas pelatihan" : null,
                          ),
                          const SizedBox(height: 32),
                          // Submit Button
                          ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF38BDF8),
                              foregroundColor: const Color(0xFF0F172A),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              shadowColor: const Color(
                                0xFF38BDF8,
                              ).withAlpha(77),
                            ),
                            child: const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Go back to login
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Already have an account? Sign In",
                              style: TextStyle(color: Color(0xFF38BDF8)),
                            ),
                          ),
                        ],
                      ),
                    ),
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

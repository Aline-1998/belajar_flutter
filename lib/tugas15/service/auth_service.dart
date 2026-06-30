import 'package:dio/dio.dart';
import 'package:lanscare_app/tugas15/model/auth_response.dart';
import 'package:lanscare_app/tugas15/model/profile_response.dart';

class AuthService {
  final Dio _dio;
  AuthService(this._dio);

  Future<AuthResponse> register(Map<String, dynamic> body) async {
    final response = await _dio.post('/api/register', data: body);
    return AuthResponse.fromJson(response.data);
  }

  Future<AuthResponse> login(Map<String, dynamic> body) async {
    final response = await _dio.post('/api/login', data: body);
    return AuthResponse.fromJson(response.data);
  }

  Future<ProfileResponse> getProfile() async {
    final response = await _dio.get('/api/profile');
    return ProfileResponse.fromJson(response.data);
  }

  Future<ProfileResponse> updateProfile(Map<String, dynamic> body) async {
    final response = await _dio.put('/api/profile', data: body);
    return ProfileResponse.fromJson(response.data);
  }

  Future<Map<String, dynamic>> updateProfilePhoto(Map<String, dynamic> body) async {
    final response = await _dio.put('/api/profile/photo', data: body);
    return response.data;
  }

  Future<Map<String, dynamic>> getUsers() async {
    final response = await _dio.get('/api/users');
    return response.data;
  }

  Future<Map<String, dynamic>> getTrainings() async {
    final response = await _dio.get('/api/trainings');
    return response.data;
  }

  Future<Map<String, dynamic>> getBatches() async {
    final response = await _dio.get('/api/batches');
    return response.data;
  }
}

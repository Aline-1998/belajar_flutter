// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModelSql {
  final int? id;
  final String nama;
  final String nik;
  final String alamat;
  final String ttl;
  final String? telp;
  final String email;
  final String password;

  UserModelSql({
    this.id,
    required this.nama,
    required this.nik,
    required this.alamat,
    required this.ttl,
    this.telp,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'nik': nik,
      'alamat': alamat,
      'ttl': ttl,
      'telp': telp,
      'email': email,
      'password': password,
    };
  }

  factory UserModelSql.fromMap(Map<String, dynamic> map) {
    return UserModelSql(
      id: map['id'] as int,
      nama: map['nama'] as String,
      nik: map['nik'] as String,
      alamat: map['alamat'] as String,
      ttl: map['ttl'] as String,
      telp: map['telp'] != null ? map['telp'] as String : null,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModelSql.fromJson(String source) =>
      UserModelSql.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginModel {
  final int? id;
  final String email;
  final String password;
  LoginModel({this.id, required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'email': email, 'password': password};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

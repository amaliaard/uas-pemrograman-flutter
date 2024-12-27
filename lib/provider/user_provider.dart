import 'package:flutter/material.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.email,
  });
}

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  // Fungsi untuk login
  Future<void> login(String id, String name, String email) async {
    // Simulasi proses login (bisa diganti dengan API)
    await Future.delayed(Duration(seconds: 2));
    _user = User(id: id, name: name, email: email);
    notifyListeners(); // Memberitahu bahwa status pengguna telah berubah
  }

  // Fungsi untuk logout
  Future<void> logout() async {
    // Simulasi proses logout (bisa diganti dengan API)
    await Future.delayed(Duration(seconds: 2));
    _user = null;
    notifyListeners();
  }

  // Mengecek apakah pengguna sudah login
  bool get isAuthenticated {
    return _user != null;
  }
}

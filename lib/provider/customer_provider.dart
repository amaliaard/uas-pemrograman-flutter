import 'package:flutter/material.dart';

class Customer {
  final String id;
  final String name;
  final String email;

  Customer({
    required this.id,
    required this.name,
    required this.email,
  });
}

class CustomerProvider with ChangeNotifier {
  List<Customer> _customers = [];

  List<Customer> get customers => _customers;

  // Fungsi untuk menambahkan pelanggan
  void addCustomer(Customer customer) {
    _customers.add(customer);
    notifyListeners(); // Memberitahu bahwa daftar pelanggan telah berubah
  }

  // Fungsi untuk menghapus pelanggan berdasarkan ID
  void removeCustomer(String id) {
    _customers.removeWhere((customer) => customer.id == id);
    notifyListeners();
  }

  // Fungsi untuk memperbarui informasi pelanggan
  void updateCustomer(String id, String name, String email) {
    final customerIndex =
        _customers.indexWhere((customer) => customer.id == id);
    if (customerIndex >= 0) {
      _customers[customerIndex] = Customer(
        id: _customers[customerIndex].id,
        name: name,
        email: email,
      );
      notifyListeners();
    }
  }
}

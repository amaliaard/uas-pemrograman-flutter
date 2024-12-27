import 'package:bakery_store/pages/user/product_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakery_store/provider/auth_provider.dart';
import 'package:bakery_store/pages/login.dart';
import 'package:bakery_store/pages/user_product_page.dart'; // Impor halaman UserProductPage

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              final success = await authProvider.logout();
              if (success) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authProvider.errorMessage)),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(255, 255, 255, 255)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'User!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildFeatureItem(
                      context,
                      icon: Icons.shopping_cart,
                      label: 'Katalog Produk',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProductPage(),
                          ),
                        );
                      },
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.favorite,
                      label: 'Favorit',
                      onTap: () {
                        // Navigasi ke halaman Favorit
                      },
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.history,
                      label: 'Riwayat Pesanan',
                      onTap: () {
                        // Navigasi ke halaman Riwayat Pesanan
                      },
                    ),
                    _buildFeatureItem(
                      context,
                      icon: Icons.account_circle,
                      label: 'Profil',
                      onTap: () {
                        // Navigasi ke halaman Profil
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.lightBlue.shade50],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                child: Icon(
                  icon,
                  size: 50,
                  color: const Color.fromARGB(255, 43, 28, 11),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:bakery_store/pages/admin/product_page.dart';
import 'package:bakery_store/pages/user/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bakery_store/pages/login.dart';
import 'package:bakery_store/provider/auth_provider.dart';
import 'package:bakery_store/provider/product_provider.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await productProvider.fetchProducts();
              if (productProvider.errorMessage.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(productProvider.errorMessage)),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildDashboardItem(
                    context,
                    icon: Icons.store,
                    label: 'Manage Products',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(), // Placeholder
                        ),
                      );
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    icon: Icons.people,
                    label: 'Manage Users',
                    onTap: () {
                      // Navigate to Manage Users Page
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    icon: Icons.analytics,
                    label: 'View Reports',
                    onTap: () {
                      // Navigate to Reports Page
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      // Navigate to Settings Page
                    },
                  ),
                  _buildDashboardItem(
                    context,
                    icon: Icons.person,
                    label: 'User Home Page',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserHomePage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: const Color.fromARGB(255, 198, 162, 98),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

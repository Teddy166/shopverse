import 'package:flutter/material.dart';
import 'upload_product_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _dashboardCard("My Products", Icons.shopping_bag, () {
              // Navigate to My Products Page
            }),
            _dashboardCard("Upload Product", Icons.add_box, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadProductPage()),
              );
            }),
            _dashboardCard("Orders", Icons.receipt_long, () {
              // Navigate to Orders Page
            }),
            _dashboardCard("Profile", Icons.person, () {
              // Navigate to Profile Page
            }),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

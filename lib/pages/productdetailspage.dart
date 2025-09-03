import 'package:flutter/material.dart';
import '../main.dart';
import 'home_page.dart'; // to use Product class

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.imageUrl,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(product.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("\$${product.price.toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 20, color: Colors.purple)),
            const SizedBox(height: 10),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text("Seller: Shopverse Mall",
                style: TextStyle(fontSize: 16, color: Colors.black87)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order placed successfully!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Order Now", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:test_project/pages/productdetailspage.dart';
import '../category_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopify Categories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: const HomePage(),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> categories = [
    "Accessories",
    "Footwear",
    "Electronics",
    "Apparel & Clothing",
    "Groceries",
    "Pet Supplies",
    "Books & Media",
    "Home & Kitchen",
    "Health & Beauty",
    "Sports & Outdoors",
    "Toys & Games",
    "Baby & Kids",
    "Automotive",
    "Tools & Home Improvement",
    "Office Supplies",
    "Garden & Patio",
    "Jewelry",
  ];

  final List<Product> products = [
    Product(
      name: "Wireless Headphones",
      imageUrl: "https://ng.jumia.is/unsafe/fit-in/500x500/filters:fill(white)/product/71/5942272/1.jpg?2129",
      price: 99.99,
      description: "High-quality wireless headphones with noise cancellation.",
    ),
    Product(
      name: "Smartwatch",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRfQpjU07Ad1cec_ydWJ-PsgRQlrconFHyunQ&s",
      price: 149.99,
      description: "Track your fitness and receive notifications on the go.",
    ),
    Product(
      name: "Ergonomic Office Chair",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFL5HO3EYuTPVq0vKi2bFq2SLcYr6CShOOkA&s",
      price: 299.99,
      description: "Comfortable and supportive chair for long working hours.",
    ),
    Product(
      name: "Portable Blender",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzz_c3kMgHAms6SQ_bJ7VMulSCQJrEq5sPJA&s",
      price: 39.99,
      description: "Make smoothies anywhere with this compact blender.",
    ),
    Product(
      name: "Fitness Tracker",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTc8sLkr0DYY74biRMQkgdctplqU2tg2hWGWg&s",
      price: 79.99,
      description: "Monitor your steps, heart rate, and sleep patterns.",
    ),
    Product(
      name: "Gaming Mouse",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbCrNdu6dUWEG-0EGpokoFKNivpTETJzPXJA&s",
      price: 49.99,
      description: "Precision gaming mouse with customizable RGB lighting.",
    ),
    Product(
      name: "Coffee Maker",
      imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2fFn8FAAdbi0Bi9IC7BdpIxa-eCBhajvmVw&s",
      price: 129.99,
      description: "Brew your perfect cup of coffee every morning.",
    ),
    Product(
      name: "Yoga Mat",
      imageUrl: "https://jadeyoga.com/cdn/shop/products/Jade-Yoga-LevelOne-Mat-Classic-Purple-Flat.jpg?v=1631819938",
      price: 24.99,
      description: "Non-slip yoga mat for comfortable workouts.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home page", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              print("Menu icon clicked");
            },
            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/images/shopverse2.jpg', fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/images/shopv.png', height: 300),
                ),
                // Categories
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final categoryName = categories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                                side: const BorderSide(color: Colors.purple, width: 1),
                              ),
                              elevation: 5,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryPage(categoryName: categoryName),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                              child: Text(
                                categoryName,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: Text(
                    "Featured Products",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(product: product),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.network(
                                  product.imageUrl,
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 120,
                                      width: double.infinity,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.broken_image, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Colors.purple,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.description,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

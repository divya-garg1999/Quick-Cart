// lib/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:quickcart/models/product_data.dart'; // Correct import path

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductData productData = ProductData(); // Accessing singleton instance
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryList(),
            SizedBox(height: 20),
            Expanded(
              child: _buildProductList(),
            ),
          ],
        ),
      ),
    );
  }

  // Horizontal list of categories
  Widget _buildCategoryList() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productData.categories.length,
        itemBuilder: (context, index) {
          final category = productData.categories[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedCategory = category;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: selectedCategory == category ? Colors.blue[900] : Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: selectedCategory == category ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Build the product list based on selected category
  Widget _buildProductList() {
    List<Product> filteredProducts = selectedCategory == 'All'
        ? productData.getAllProducts()
        : productData.getProductsByCategory(selectedCategory);

    if (filteredProducts.isEmpty) {
      return Center(
        child: Text(
          'No products available.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(product.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Category: ${product.category}'),
                Text('Price: \$${product.price.toStringAsFixed(2)}'),
                Text(
                  'Stock: ${product.stock > 0 ? product.stock.toString() : 'Out of Stock'}',
                  style: TextStyle(
                    color: product.stock > 0 ? Colors.black : Colors.red,
                  ),
                ),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}

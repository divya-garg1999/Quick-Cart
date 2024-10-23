// lib/views/add_product_screen.dart

import 'package:flutter/material.dart';
import 'package:quickcart/models/product_data.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ProductData productData = ProductData(); // Accessing singleton instance
  String? selectedCategory;

  // Controllers for product details
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();

  // Method to add the product
  void _addProduct() {
    final productName = nameController.text.trim();
    final productPriceText = priceController.text.trim();
    final productStockText = stockController.text.trim();

    if (productName.isEmpty ||
        selectedCategory == null ||
        productPriceText.isEmpty ||
        productStockText.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    // Parse price and stock
    final double? productPrice = double.tryParse(productPriceText);
    final int? productStock = int.tryParse(productStockText);

    if (productPrice == null || productStock == null) {
      _showSnackBar('Please enter valid numbers for price and stock');
      return;
    }

    // Add the product to the singleton
    productData.addProduct(
      productName,
      selectedCategory!,
      productPrice,
      productStock,
    );

    // Clear fields after adding the product
    nameController.clear();
    priceController.clear();
    stockController.clear();
    setState(() {
      selectedCategory = null; // Reset selected category
    });

    _showSnackBar('Product Added Successfully');
    print('Product Added: $productName, Category: $selectedCategory, Price: $productPrice, Stock: $productStock');
  }

  // Method to show a dialog for adding a new category
  void _showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Category'),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(hintText: 'Category Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newCategory = categoryController.text.trim();
                if (newCategory.isNotEmpty) {
                  productData.addCategory(newCategory);
                  categoryController.clear(); // Clear input field
                  Navigator.of(context).pop();
                  _showSnackBar('Category Added Successfully');
                } else {
                  _showSnackBar('Category name cannot be empty');
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Helper method to show SnackBar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Dropdown to choose category
  Widget _buildCategoryDropdown() {
    return Container(
      decoration: _inputFieldDecoration(),
      child: DropdownButton<String>(
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Choose a category'),
        ),
        value: selectedCategory,
        onChanged: (String? newValue) {
          setState(() {
            selectedCategory = newValue;
          });
        },
        isExpanded: true,
        items: productData.categories.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          );
        }).toList(),
      ),
    );
  }

  // General method to build a text field for the form
  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Container(
      decoration: _inputFieldDecoration(),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.all(16),
        ),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      ),
    );
  }

  // Input field decoration
  BoxDecoration _inputFieldDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add Product',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Select Category:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                _buildCategoryDropdown(),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: _showAddCategoryDialog,
                  child: Text('Add Category', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                SizedBox(height: 20),
                if (selectedCategory != null) ...[
                  Text('Add Product Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  _buildTextField(nameController, 'Product Name'),
                  SizedBox(height: 10),
                  _buildTextField(priceController, 'Price', isNumber: true),
                  SizedBox(height: 10),
                  _buildTextField(stockController, 'Stock', isNumber: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addProduct,
                    child: Text('Add Product'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickcart/models/product_data.dart';

class AddProductController extends GetxController {
  final ProductData productData = ProductData(); // Singleton instance
  var selectedCategory = Rxn<String>(); // Reactive category selection
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final categoryController = TextEditingController();

  // Method to add the product
  void addProduct() {
    final productName = nameController.text.trim();
    final productPriceText = priceController.text.trim();
    final productStockText = stockController.text.trim();

    if (productName.isEmpty || selectedCategory.value == null || productPriceText.isEmpty || productStockText.isEmpty) {
      _showSnackBar('Please fill in all fields');
      return;
    }

    final double? productPrice = double.tryParse(productPriceText);
    final int? productStock = int.tryParse(productStockText);

    if (productPrice == null || productStock == null) {
      _showSnackBar('Please enter valid numbers for price and stock');
      return;
    }

    productData.addProduct(
      productName,
      selectedCategory.value!,
      productPrice,
      productStock,
    );

    // Clear fields after adding the product
    nameController.clear();
    priceController.clear();
    stockController.clear();
    selectedCategory.value = null; // Reset selected category
    _showSnackBar('Product Added Successfully');
  }

  void addCategory() {
    final newCategory = categoryController.text.trim();
    if (newCategory.isNotEmpty) {
      productData.addCategory(newCategory);
      categoryController.clear(); // Clear input field
      Get.back(); // Close dialog
      _showSnackBar('Category Added Successfully');
    } else {
      _showSnackBar('Category name cannot be empty');
    }
  }

  // Show SnackBar using GetX
  void _showSnackBar(String message) {
    Get.snackbar('Notification', message, snackPosition: SnackPosition.BOTTOM);
  }
}

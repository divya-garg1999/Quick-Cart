import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quickcart/models/product_data.dart';

class AddProductController extends GetxController {
  final ProductData productData = ProductData(); // Access to the product data
  final RxString selectedCategory = 'All'.obs;

  // Text controllers for the dialog inputs
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  // Method to update the selected category
  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  // Method to add a new category
  void addCategory() {
    if (categoryController.text.isNotEmpty) {
      productData.addCategory(categoryController.text);
      categoryController.clear(); // Clear the input after adding
      Get.back(); // Close the dialog
    }
  }

  // Method to add a new product
  void addProduct() {
    final String name = nameController.text;
    final double price = double.tryParse(priceController.text) ?? 0.0;
    final int stock = int.tryParse(stockController.text) ?? 0;

    if (name.isNotEmpty && price > 0 && stock >= 0 && selectedCategory.value != 'All') {
      productData.addProduct(name, selectedCategory.value, price, stock);
      nameController.clear();
      priceController.clear();
      stockController.clear();
      Get.back(); // Close the dialog
    }
  }

  @override
  void onClose() {
    // Dispose of text controllers to avoid memory leaks
    categoryController.dispose();
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.onClose();
  }
}
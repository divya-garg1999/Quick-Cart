import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../database/DatabaseHelper.dart';
import '../../models/CategoryData.dart';
import '../../models/ProductData.dart';

class AddProductController extends GetxController {
  // Controller for the text input
  TextEditingController categoryController = TextEditingController();

  // List of categories - this can be replaced with your database or storage logic
  RxList<CategoryData> categories = <CategoryData>[].obs; // Singleton instance
  RxList<ProductData> productList = <ProductData>[].obs; // Singleton instance

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();

  // To keep track of the selected category (optional, for UI logic)
  RxString selectedCategory = ''.obs;

  final DatabaseHelper dbHelper = DatabaseHelper(); // Instance of DatabaseHelper

  // Function to add a new category if it doesn't already exist
  Future<int> addCategory(String newCategory) async {
    if (newCategory.isNotEmpty) {
      // Check if the category already exists in the local list (case insensitive comparison)
      bool categoryExists = categories.any((category) =>
      category.name.toLowerCase() == newCategory.toLowerCase());

      if (!categoryExists) {
        // Add the category to the database
        CategoryData categoryData = CategoryData(name: newCategory);
        int id = await dbHelper.addCategory(categoryData);

        if (id > 0) {
          // Successfully added, update the local list
          Get.snackbar('Success', 'Category "$newCategory" added successfully!',
              snackPosition: SnackPosition.BOTTOM);
          fetchCategories();
          return 1;
        } else {
          // Show an error if the database insertion failed
          Get.snackbar(
              'Database Error', 'Failed to add category "$newCategory".',
              snackPosition: SnackPosition.BOTTOM);
          return 0;
        }
      } else {
        // Show a warning if the category already exists
        Get.snackbar(
            'Category Exists', 'The category "$newCategory" already exists.',
            snackPosition: SnackPosition.BOTTOM);
        return 0;
      }
    } else {
      Get.snackbar(
          'Invalid Entry', 'The category cannot be empty',
          snackPosition: SnackPosition.BOTTOM);
      return 0;
    }
  }


  // Method to add a new product
  Future<int> addProduct(
      String name, String price, int stock, int? categoryId, String? categoryName) async {
    if (name.isEmpty || price.isEmpty || stock <= 0 || categoryId == null || categoryName == null) {
      // Validation failed, show an error
      Get.snackbar('Error', 'All fields are mandatory and must be valid.',
          snackPosition: SnackPosition.BOTTOM);
      return 0;
    }

    // Create a product object (assume you have a ProductData class, or replace with your actual class)
    ProductData newProduct = ProductData(
      name: name,
      price: price,
      stock: stock.toString(),
      categoryId: categoryId,
      categoryName: categoryName,
    );

    // Add product to database (adjust according to your DatabaseHelper implementation)
    int result = await dbHelper.addProduct(newProduct);

    if (result > 0) {
      // Success message
      Get.snackbar('Success', 'Product "$name" added successfully!',
          snackPosition: SnackPosition.BOTTOM);
      return 1;
    } else {
      // Error message
      Get.snackbar('Database Error', 'Failed to add the product "$name".',
          snackPosition: SnackPosition.BOTTOM);

      return 0;
    }
  }


  void fetchCategories() async {
    // Fetch categories from the database
    List<CategoryData> dbCategories = await dbHelper.getCategories();
    categories.clear();
    categories.addAll(dbCategories); // Update local list
  }

  void fetchAllProduct() async {
    // Fetch categories from the database
    List<ProductData> dbProduct = await dbHelper.getAllProducts();
    productList.clear();
    productList.addAll(dbProduct); // Update local list
  }

  // Optional: Update selected category logic
  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  // Dispose controllers when done
  @override
  void onClose() {
    categoryController.dispose();
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.onClose();
  }
}

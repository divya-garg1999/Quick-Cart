import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../database/DatabaseHelper.dart';
import '../../models/CategoryData.dart';

class AddProductController extends GetxController {
  // Controller for the text input
  TextEditingController categoryController = TextEditingController();

  // List of categories - this can be replaced with your database or storage logic
  RxList<String> categories = <String>[].obs; // Singleton instance

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
      category.toLowerCase() == newCategory.toLowerCase());

      if (!categoryExists) {
        // Add the category to the database
        CategoryData categoryData = CategoryData(name: newCategory);
        int id = await dbHelper.addCategory(categoryData);

        if (id > 0) {
          // Successfully added, update the local list
          categories.add(newCategory);
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

  void fetchCategories() async {
    // Fetch categories from the database
    List<CategoryData> dbCategories = await dbHelper.getCategories();
    categories.addAll(dbCategories.map((e) => e.name)); // Update local list
  }

  // Optional: Update selected category logic
  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  // Dispose controllers when done
  @override
  void onClose() {
    categoryController.dispose();
    super.onClose();
  }
}

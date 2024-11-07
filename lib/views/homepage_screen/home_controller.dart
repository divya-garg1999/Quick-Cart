import 'package:get/get.dart';
import 'package:quickcart/models/product_data.dart'; // Correct import path

class HomeController extends GetxController {
  final productData = ProductData(); // Accessing singleton instance
  var selectedCategory = 'All'.obs;
  var searchQuery = ''.obs; // To store the search query
  var filteredProducts = <Product>[].obs; // Observable list to trigger updates

  @override
  void onInit() {
    super.onInit();
    // Initially populate filteredProducts with all products
    filteredProducts.addAll(productData.getAllProducts());
  }

  // Get products based on selected category and search query
  void updateFilteredProducts() {
    List<Product> allProducts = selectedCategory.value == 'All'
        ? productData.getAllProducts()
        : productData.getProductsByCategory(selectedCategory.value);

    if (searchQuery.value.isNotEmpty) {
      // Filter products by the search query (name match)
      filteredProducts.value = allProducts
          .where((product) =>
          product.name.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    } else {
      // If no search query, just return filtered by category
      filteredProducts.value = allProducts;
    }
  }

  // Change selected category and update filtered products
  void selectCategory(String category) {
    selectedCategory.value = category;
    updateFilteredProducts(); // Update products when category changes
  }

  // Update search query and update filtered products
  void searchProducts(String query) {
    searchQuery.value = query;
    updateFilteredProducts(); // Update products when search query changes
  }
}

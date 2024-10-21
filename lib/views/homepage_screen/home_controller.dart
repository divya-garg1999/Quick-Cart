import 'package:get/get.dart';
import 'package:quickcart/models/product_data.dart'; // Correct import path

class HomeController extends GetxController {
  final productData = ProductData(); // Accessing singleton instance
  var selectedCategory = 'All'.obs;

  // Get products based on selected category
  List<Product> get filteredProducts {
    if (selectedCategory.value == 'All') {
      return productData.getAllProducts();
    } else {
      return productData.getProductsByCategory(selectedCategory.value);
    }
  }

  // Change selected category
  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart'; // Import the controller
import 'package:quickcart/models/product_data.dart'; // Update with your correct path


class HomeScreen extends StatelessWidget {
final HomeController controller = Get.put(HomeController());

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
child: Obx(() => _buildProductList()), // Observe the product list changes
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
itemCount: controller.productData.categories.length,
itemBuilder: (context, index) {
final category = controller.productData.categories[index];
return GestureDetector(
onTap: () {
controller.selectCategory(category); // Use the controller method
},
child: Obx(() => Container(
padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
margin: EdgeInsets.only(right: 10),
decoration: BoxDecoration(
color: controller.selectedCategory.value == category ? Colors.blue[900] : Colors.grey[300],
borderRadius: BorderRadius.circular(30),
),
child: Center(
child: Text(
category,
style: TextStyle(
color: controller.selectedCategory.value == category ? Colors.white : Colors.black,
fontWeight: FontWeight.bold,
),
),
),
)),
);
},
),
);
}

// Build the product list based on selected category
Widget _buildProductList() {
List<Product> filteredProducts = controller.filteredProducts;

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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart'; // Import the controller
import 'package:quickcart/models/product_data.dart'; // Correct import path

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final TextEditingController searchController = TextEditingController(); // Controller for search input

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back button
        title: Text(''),
        actions: [
          // You can add any actions like shopping cart or settings here
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Reduced height for the search bar
            Container(
              margin: EdgeInsets.only(bottom: 16),
              // Reduced margin for search bar
              child: TextField(
                controller: searchController,
                onChanged: (query) {
                  controller.searchProducts(query); // Call the search function whenever input changes
                },
                decoration: InputDecoration(
                  hintText: 'Search for products...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0), // Reduced height
                ),
              ),
            ),
            // Horizontal category list with larger capsules
            _buildCategoryList(),
            SizedBox(height: 16),
            // Reduced space between categories and products
            Expanded(
              child: Obx(() =>
                  _buildProductList()), // Observe the product list changes
            ),
          ],
        ),
      ),
    );
  }

  // Horizontal list of categories with larger capsules and color change on click
  Widget _buildCategoryList() {
    return Container(
      height: 50, // Keeping the same height for the capsules
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.productData.categories.length,
        itemBuilder: (context, index) {
          final category = controller.productData.categories[index];
          return GestureDetector(
            onTap: () {
              controller.selectCategory(category); // Use the controller method
            },
            child: Obx(() =>
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  // Applied capsule size (horizontal padding 12, vertical padding 8)
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.selectedCategory.value == category
                        ? Colors.blue[900]
                        : Colors.grey[300], // Purple when selected
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        color: controller.selectedCategory.value == category
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14, // Slightly larger font size
                      ),
                    ),
                  ),
                )),
          );
        },
      ),
    );
  }

  // Build the product list based on selected category and search query
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

    return GridView.builder(
      shrinkWrap: true,
      // Allow the GridView to take up only the space it needs
      physics: NeverScrollableScrollPhysics(),
      // Prevent GridView from scrolling
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 products in a row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7, // Adjusted aspect ratio for smaller product boxes
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];

        return Card(
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Smaller image for the product
              Image.network(
                'https://via.placeholder.com/150',
                // Replace with product image URL
                fit: BoxFit.cover,
                height: 60, // Reduced height for the product image
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
              Spacer(), // Push the button to the bottom
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price at the bottom left
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    // Cart icon at the bottom right
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart, size: 20,
                            color: Colors.blue[900]),
                        // Cart symbol in dark purple
                        onPressed: () {
                          // Implement add to cart functionality
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

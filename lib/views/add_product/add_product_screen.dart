import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_product_controller.dart';
import 'package:quickcart/models/product_data.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header with 'Add Category' button on the same line
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Category',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Add Category'),
                        content: TextField(
                          controller: controller.categoryController,
                          decoration: InputDecoration(hintText: 'Category Name'),
                        ),
                        actions: [
                          TextButton(
                            onPressed: controller.addCategory,
                            child: Text('Add'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text('Add Category'),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Horizontal category list
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.productData.categories.map((category) {
                    return GestureDetector(
                      onTap: () => controller.updateCategory(category),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: controller.selectedCategory.value == category
                              ? Colors.blue[900]
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: controller.selectedCategory.value == category
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
            SizedBox(height: 16),
            // Displaying products based on selected category
            Expanded(
              child: Obx(() {
                final selectedCategory = controller.selectedCategory.value;
                final products = controller.productData.getProductsByCategory(selectedCategory);

                return products.isEmpty
                    ? Center(child: Text('No products found in this category'))
                    : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Price: \$${product.price} | Stock: ${product.stock}'),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 16),
            // Add Product button at the bottom center
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Add Product'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: controller.nameController,
                            decoration: InputDecoration(hintText: 'Product Name'),
                          ),
                          TextField(
                            controller: controller.priceController,
                            decoration: InputDecoration(hintText: 'Price'),
                            keyboardType: TextInputType.number,
                          ),
                          TextField(
                            controller: controller.stockController,
                            decoration: InputDecoration(hintText: 'Stock'),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            controller.addProduct(); // Call the method to add the product
                            Navigator.pop(context); // Close the dialog after submission
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Add Product'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

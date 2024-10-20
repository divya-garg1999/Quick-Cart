import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_product_controller.dart';

class AddProductScreen extends StatelessWidget {
  final AddProductController controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
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
                  onPressed: () => _showAddCategoryDialog(),
                  child: Text('Add Category', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.selectedCategory.value != null) {
                    return Column(
                      children: [
                        Text('Add Product Details:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        _buildTextField(controller.nameController, 'Product Name'),
                        SizedBox(height: 10),
                        _buildTextField(controller.priceController, 'Price', isNumber: true),
                        SizedBox(height: 10),
                        _buildTextField(controller.stockController, 'Stock', isNumber: true),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: controller.addProduct,
                          child: Text('Add Product'),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Dropdown for choosing category
  Widget _buildCategoryDropdown() {
    return Container(
      decoration: _inputFieldDecoration(),
      child: Obx(() {
        return DropdownButton<String>(
          hint: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Choose a category'),
          ),
          value: controller.selectedCategory.value,
          onChanged: (String? newValue) {
            controller.selectedCategory.value = newValue;
          },
          isExpanded: true,
          items: controller.productData.categories
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(value),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

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

  // Method to show a dialog for adding a new category
  void _showAddCategoryDialog() {
    Get.defaultDialog(
      title: 'Add Category',
      content: TextField(
        controller: controller.categoryController,
        decoration: InputDecoration(hintText: 'Category Name'),
      ),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
        TextButton(onPressed: controller.addCategory, child: Text('Add')),
      ],
    );
  }
}

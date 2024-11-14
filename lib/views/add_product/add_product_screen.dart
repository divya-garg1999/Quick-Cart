import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/CategoryData.dart';
import 'add_product_controller.dart';
import 'package:quickcart/models/product_data.dart';

class AddProductScreen extends StatefulWidget {

  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final AddProductController controller = Get.put(AddProductController());

  @override
  void initState() {
    super.initState();
    controller.fetchCategories();
    controller.fetchAllProduct();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        title: const Text('Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header with 'Add Category' button on the same line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // Set corner radius to 5
                      ),
                    ),
                    onPressed: () {
                      showAddCategoryDialog();
                    },
                    child: const Text(
                      '+ Add New',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
           // Horizontal category list
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.categories.map((category) {
                    return GestureDetector(
                      onTap: () => controller.updateCategory(category.name),
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
                          category.name,
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
            Obx(() {

              final products = controller.productList;

              return products.isEmpty
                  ? Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('No products found in this category'),
              ))
                  : ListView.builder(
                shrinkWrap: true, // Important to prevent overflow
                physics: NeverScrollableScrollPhysics(), // Disable scrolling within ListView
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Price: \$${product.price} | Stock: ${product.stock} | Category: ${product.categoryName}'),
                  );
                },
              );
            }),
            SizedBox(height: 16),

            // Add Product button at the bottom center
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addNewProduct();
                },
                child: Text('Add Product'),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void showAddCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Category'),
        content: TextField(
          controller: controller.categoryController,
          decoration: const InputDecoration(hintText: 'Category Name'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final newCategory = controller.categoryController.text.trim();
              var status = await controller.addCategory(newCategory);
              if(status == 1){
                controller.categoryController.text = "";
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );


  }

  void addNewProduct() {
    RxList<CategoryData> catList = controller.categories; // Assuming it's an RxList<CategoryData>
    String? selectedCategory;
    int? selectedId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Product'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
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
              DropdownButtonFormField<CategoryData>(
                value: selectedId != null
                    ? catList.firstWhereOrNull((category) => category.id == selectedId)
                    : null,
                hint: Text('Select Category'),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedId = value.id;
                      selectedCategory = value.name;
                    }
                  });
                },
                items: catList.map<DropdownMenuItem<CategoryData>>((category) {
                  return DropdownMenuItem<CategoryData>(
                    value: category,
                    child: Text(category.name), // Assuming CategoryData has 'name'
                  );
                }).toList(),
                validator: (value) => value == null ? 'Category is required' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.nameController.text.isEmpty ||
                  controller.priceController.text.isEmpty ||
                  controller.stockController.text.isEmpty ||
                  selectedId == null) {
                // Show error if any field is empty
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All fields are mandatory')),
                );
              } else {
                var status = await controller.addProduct(controller.nameController.text, controller.priceController.text.toString(), int.parse(controller.stockController.text), selectedId, selectedCategory);
                if(status == 1){
                  controller.nameController.text = "";
                  controller.priceController.text = "";
                  controller.stockController.text = "";
                  Navigator.pop(context);
                  controller.fetchAllProduct();
                }

              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }



}

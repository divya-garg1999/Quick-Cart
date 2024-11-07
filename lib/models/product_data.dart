import 'package:get/get.dart';

// Product class
class Product {
  final String name;
  final String category;
  final double price;
  final int stock;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });
}

// ProductData class using GetX
class ProductData extends GetxController {
  // Singleton pattern
  ProductData._privateConstructor();
  static final ProductData _instance = ProductData._privateConstructor();
  factory ProductData() {
    return _instance;
  }

  // Reactive list of categories including 'All'
  final RxList<String> _categories = ['All', 'Electronics', 'Clothing', 'Groceries'].obs;

  // Reactive list of products
  final RxList<Product> _products = <Product>[
    Product(name: 'Laptop', category: 'Electronics', price: 999.99, stock: 10),
    Product(name: 'Smartphone', category: 'Electronics', price: 699.99, stock: 25),
    Product(name: 'T-Shirt', category: 'Clothing', price: 19.99, stock: 0),
    Product(name: 'Jeans', category: 'Clothing', price: 49.99, stock: 15),
    Product(name: 'Bread', category: 'Groceries', price: 2.49, stock: 50),
    Product(name: 'Milk', category: 'Groceries', price: 1.99, stock: 30),
  ].obs;

  // Getters for reactive categories and products
  List<String> get categories => _categories;
  List<Product> get products => _products;

  /// Returns all products
  List<Product> getAllProducts() {
    return _products.toList();
  }

  /// Returns products filtered by the given category
  List<Product> getProductsByCategory(String category) {
    if (category == 'All') {
      return getAllProducts();
    }
    return _products.where((product) => product.category == category).toList();
  }

  /// Async method to fetch products by category as Future
  Future<List<Product>> getProductsByCategoryFuture(String category) async {
    // Simulate delay for loading data
    await Future.delayed(Duration(milliseconds: 500));
    return getProductsByCategory(category);
  }

  /// Adds a new product and notifies listeners
  void addProduct(String name, String category, double price, int stock) {
    if (name.isNotEmpty && price >= 0 && stock >= 0 && _categories.contains(category)) {
      _products.add(Product(
        name: name,
        category: category,
        price: price,
        stock: stock,
      ));
    }
  }

  /// Adds a new category and notifies listeners
  void addCategory(String category) {
    if (!_categories.contains(category) && category.isNotEmpty) {
      _categories.add(category);
    }
  }

  /// Updates an existing product with new details
  void updateProduct(Product product, String name, double price, int stock) {
    final index = _products.indexOf(product);
    if (index != -1) {
      _products[index] = Product(
        name: name,
        category: product.category, // Maintain the original category
        price: price,
        stock: stock,
      );
    }
  }
}
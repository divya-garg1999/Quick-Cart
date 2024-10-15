// lib/models/product_data.dart

class ProductData {
  // Private constructor for Singleton pattern
  ProductData._privateConstructor();

  // Single instance of ProductData
  static final ProductData _instance = ProductData._privateConstructor();

  // Factory constructor to return the same instance every time
  factory ProductData() {
    return _instance;
  }

  // List of categories including 'All'
  final List<String> _categories = ['All', 'Electronics', 'Clothing', 'Groceries'];

  // List of products
  final List<Product> _products = [
    Product(name: 'Laptop', category: 'Electronics', price: 999.99, stock: 10),
    Product(name: 'Smartphone', category: 'Electronics', price: 699.99, stock: 25),
    Product(name: 'T-Shirt', category: 'Clothing', price: 19.99, stock: 0),
    Product(name: 'Jeans', category: 'Clothing', price: 49.99, stock: 15),
    Product(name: 'Bread', category: 'Groceries', price: 2.49, stock: 50),
    Product(name: 'Milk', category: 'Groceries', price: 1.99, stock: 30),
  ];

  // Getters for categories and products
  List<String> get categories => _categories;
  List<Product> get products => _products;

  /// Returns all products
  List<Product> getAllProducts() {
    return _products;
  }

  /// Returns products filtered by the given category
  List<Product> getProductsByCategory(String category) {
    if (category == 'All') {
      return getAllProducts();
    }
    return _products.where((product) => product.category == category).toList();
  }

  /// Adds a new product
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

  /// Adds a new category
  void addCategory(String category) {
    if (!_categories.contains(category) && category.isNotEmpty) {
      _categories.add(category);
    }
  }
}

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

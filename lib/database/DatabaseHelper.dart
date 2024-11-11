import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/CategoryData.dart';
import '../models/ProductData.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton object
  static Database? _database;


  String categoryTable = 'categories';
  String productTable = 'products';

  String categoryId = 'id';
  String categoryName = 'name';

  String productId = 'id';
  String productName = 'name';
  String productPrice = 'price';
  String productCategoryId = 'categoryId';

  // Private constructor for singleton pattern
  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  // Getter for database instance
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  // Initialize the database
  Future<Database> initializeDatabase() async {
    String path = '${await getDatabasesPath()}/products.db';

    var productDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
    );

    print("Database Created");
    return productDatabase;
  }

  // Function for creating tables
  void _createTable(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE $categoryTable (
        $categoryId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $categoryName TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE $productTable (
        $productId INTEGER PRIMARY KEY AUTOINCREMENT, 
        $productName TEXT NOT NULL, 
        $productPrice REAL NOT NULL, 
        $productCategoryId INTEGER, 
        FOREIGN KEY($productCategoryId) REFERENCES $categoryTable($categoryId) ON DELETE SET NULL
      )
    ''');
  }

  // Add category
  Future<int> addCategory(CategoryData category) async {
    Database db = await this.database;
    var result = await db.insert(categoryTable, category.toMap());
    print("Category added: ${category.name}");
    return result;
  }

  // Get all categories
  Future<List<CategoryData>> getCategories() async {
    Database db = await this.database;
    var result = await db.query(categoryTable);
    return result.map((category) => CategoryData.fromMap(category)).toList();
  }

  // Add product
  Future<int> addProduct(ProductData product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    print("Product added: ${product.name}");
    return result;
  }

  // Get products by category ID
  Future<List<ProductData>> getProductsByCategory(int categoryId) async {
    Database db = await this.database;
    var result = await db.query(
      productTable,
      where: '$productCategoryId = ?',
      whereArgs: [categoryId],
    );
    return result.map((product) => ProductData.fromMap(product)).toList();
  }

  // Get all products
  Future<List<ProductData>> getAllProducts() async {
    Database db = await this.database;
    var result = await db.query(productTable);
    return result.map((product) => ProductData.fromMap(product)).toList();
  }
}

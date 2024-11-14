
class ProductData {
  int? id; // id can be null for new products
  String name;
  String price;
  String stock;
  int? categoryId;
  String? categoryName;

  ProductData({this.id, required this.name, required this.price, required this.stock, this.categoryId, this.categoryName});

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'stock': stock,
      'categoryId': categoryId,
      'categoryName': categoryName,
    };
  }

  // Convert a Map into a Product
  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
        id: map['id'],
        name: map['name'],
        price: map['price'].toString(),
        stock: map['stock'].toString(),
        categoryId: map['categoryId'],
        categoryName: map['categoryName']
    );
  }
}

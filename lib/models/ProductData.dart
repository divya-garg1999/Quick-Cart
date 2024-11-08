
class ProductData {
  int? id; // id can be null for new products
  String name;
  double price;
  int? categoryId; // Nullable category ID

  ProductData({this.id, required this.name, required this.price, this.categoryId});

  // Convert a Product into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'categoryId': categoryId,
    };
  }

  // Convert a Map into a Product
  factory ProductData.fromMap(Map<String, dynamic> map) {
    return ProductData(
        id: map['id'],
        name: map['name'],
        price: map['price'],
        categoryId: map['categoryId']
    );
  }
}

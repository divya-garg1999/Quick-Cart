
class CategoryData {
  int? id; // id can be null for new categories
  String name;

  CategoryData({this.id, required this.name});

  // Convert a Category into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Convert a Map into a Category
  factory CategoryData.fromMap(Map<String, dynamic> map) {
    return CategoryData(
      id: map['id'],
      name: map['name'],
    );
  }
}

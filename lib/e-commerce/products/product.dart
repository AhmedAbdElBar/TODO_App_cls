class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.name, required this.id, required this.price});
  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "price": price};
  }

  Product.fromMap(Map<String, dynamic> map)
    : id = map["id"],
      name = map["name"],
      price = map["price"];
}

final List<Product> items = [
  Product(name: "Product 1", id: 1, price: 10.0),
  Product(name: "Product 2", id: 2, price: 20.0),
  Product(name: "Product 3", id: 3, price: 30.0),
  Product(name: "Product 4", id: 4, price: 40.0),
  Product(name: "Product 5", id: 5, price: 50.0),
  Product(name: "Product 6", id: 6, price: 60.0),
  Product(name: "Product 7", id: 7, price: 70.0),
  Product(name: "Product 8", id: 8, price: 80.0),
  Product(name: "Product 9", id: 9, price: 90.0),
  Product(name: "Product 10", id: 10, price: 100.0),
];

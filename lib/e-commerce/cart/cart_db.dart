import 'package:flutter_r5_s2/e-commerce/products/product.dart';
import 'package:sqflite/sqflite.dart';

class CartDb {
  static late Database database;
  final String tableName = "Cart";

  Future<void> initialDb() async {
    var databaseDirectoryPath = await getDatabasesPath();
    String filePath = '$databaseDirectoryPath/cart.db';
    database = await openDatabase(
      filePath,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE $tableName(id INTEGER PRIMARY KEY,name TEXT,price REAL)",
        );
      },
    );
  }

  Future<void> addProduct(Product product) async {
    database.insert(tableName, product.toMap());
  }

  Future<void> removeProduct(int id) async {
    await database.delete(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Product>> getAllProduct() async {
    final List<Map<String, dynamic>> productsMaps = await database.query(
      tableName,
    );
    List<Product> products = [];
    for (var map in productsMaps) {
      products.add(Product.fromMap(map));
    }
    return products;
  }

  Future<void> clearAllProducts() async {
    await database.delete(tableName);
  }
}

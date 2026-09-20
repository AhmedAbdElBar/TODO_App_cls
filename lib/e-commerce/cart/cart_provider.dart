import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/e-commerce/cart/cart_db.dart';

import '../products/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> items = [];

  Future<void> initCart() async {
    items = await CartDb().getAllProduct();
    notifyListeners();
  }

  Future<void> addToList(Product product) async {
    items.add(product);
    notifyListeners();
    await CartDb().addProduct(product);
  }

  Future<void> rmoveFormList(Product product) async {
    items.remove(product);
    await CartDb().removeProduct(product.id);
    notifyListeners();
  }

  void clearAll() async {
    items.clear();
    await CartDb().clearAllProducts();
    notifyListeners();
  }

  bool isInCart(Product product) {
    return items.any((element) => element.id == product.id);
  }

  double getTotal() {
    double total = 0;
    for (int i = 0; i < items.length; i++) {
      total += items[i].price;
    }
    return total;
  }
}

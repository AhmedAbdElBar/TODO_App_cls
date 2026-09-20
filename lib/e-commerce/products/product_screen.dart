import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/e-commerce/cart/cart_provider.dart';
import 'package:flutter_r5_s2/e-commerce/cart/cart_screen.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    Provider.of<CartProvider>(context, listen: false).initCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Products"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Badge(
              label: Text(
                "${cartProvider.items.length}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              isLabelVisible: cartProvider.items.isNotEmpty,
              alignment: Alignment.topRight,
              offset: const Offset(-6, 4),
              padding: const EdgeInsets.all(3),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart_outlined, size: 30),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            bool isAdded = cartProvider.isInCart(items[index]);
            return ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Text("${items[index].id}"),
              ),
              title: Text(items[index].name),
              subtitle: Text("${items[index].price}"),
              trailing: isAdded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Icon(Icons.check, color: Colors.green, size: 30),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        cartProvider.addToList(items[index]);
                      },
                      child: Icon(Icons.add),
                    ),
            );
          },
        ),
      ),
    );
  }
}

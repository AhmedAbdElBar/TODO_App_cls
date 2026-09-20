import 'package:flutter/material.dart';
import 'package:flutter_r5_s2/e-commerce/cart/cart_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "cart",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  cartProvider.clearAll();
                },
                icon: Icon(Icons.clear_all),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: cartProvider.items.isEmpty
                    ? Center(child: Text("cart empty"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cartProvider.items.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              child: Text("${cartProvider.items[index].id}"),
                            ),
                            title: Text(cartProvider.items[index].name),
                            subtitle: Text(cartProvider.items[index].name),
                            trailing: ElevatedButton(
                              onPressed: () {
                                cartProvider.rmoveFormList(
                                  cartProvider.items[index],
                                );
                              },
                              child: Icon(Icons.remove),
                            ),
                          );
                        },
                      ),
              ),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${cartProvider.getTotal()}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Checkout",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

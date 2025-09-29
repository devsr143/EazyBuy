import 'package:flutter/material.dart';
import 'package:pack_bags/pack_it/view/py.dart';
import 'package:pack_bags/pack_it/view_model/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("MY CART",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
      ),
      body: cartProvider.cartItems.isEmpty
          ? const Center(
        child: Text("Your cart is empty",style: TextStyle(color: Colors.white),),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final product =
                cartProvider.cartItems.keys.toList()[index];
                final quantity =
                cartProvider.cartItems.values.toList()[index];
                return Card(
                  color: Colors.white70,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: product.images != null &&
                        product.images!.isNotEmpty
                        ? Image.network(product.images!.first,
                        width: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image_not_supported),
                    title: Text(product.title ?? "No title"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$${product.price?.toString() ?? '0'}",
                          style: const TextStyle(color: Colors.teal),
                        ),
                        Text(
                          "Subtotal: \$${((product.price ?? 0) * quantity).toString()}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 160,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle,
                                color: Colors.black),
                            onPressed: () {
                              cartProvider.decreaseQuantity(product);
                            },
                          ),

                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),

                          IconButton(
                            icon: const Icon(Icons.add_circle,
                                color: Colors.black),
                            onPressed: () {
                              cartProvider.increaseQuantity(product);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () {
                              cartProvider.removeFromCart(product);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Item removed")),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white70,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                    onPressed: () {
                      if (cartProvider.cartItems.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Nothing in cart")),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  PaymentPage()),
                      );
                    },
                  child: const Text(
                    "PURCHASE",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final String deliveryAddress;
  final Map cartItems;
  final double totalAmount;
  final String paymentMethod;

  const OrderDetailsPage({
    super.key,
    required this.deliveryAddress,
    required this.cartItems,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("ORDERS", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Delivery Address:",
                style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(deliveryAddress, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const Divider(color: Colors.white24, height: 30),

            const Text("Payment Method:",
                style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(paymentMethod, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const Divider(color: Colors.white24, height: 30),

            const Text("Ordered Items:",
                style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartItems.keys.toList()[index];
                  final quantity = cartItems.values.toList()[index];
                  return ListTile(
                    leading: product.images != null && product.images!.isNotEmpty
                        ? Image.network(product.images!.first, width: 50)
                        : const Icon(Icons.image, color: Colors.white),
                    title: Text(product.title ?? "No title",
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      "x$quantity • \$${(product.price ?? 0) * quantity}",
                      style: const TextStyle(color: Colors.teal),
                    ),
                  );
                },
              ),
            ),

            const Divider(color: Colors.white24),
            Text(
              "Total: \$${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

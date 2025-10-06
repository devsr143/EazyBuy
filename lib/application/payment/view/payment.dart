import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pack_bags/application/rootpage/view/root_page.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import '../../address/model/address_model.dart';
import '../../cart/view_model/cart_provider.dart';
import '../view_model/payment_provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaymentProvider()..fetchFirebaseAddresses(),
      child: const PaymentPageContent(),
    );
  }
}

class PaymentPageContent extends StatelessWidget {
  const PaymentPageContent({super.key});

  Future<void> showOrderSuccessAnimation(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              'assets/animation/Success.json',
              width: 80,
              repeat: false,
              onLoaded: (composition) {
                Future.delayed(composition.duration, () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RootPage()),
                  );
                });
              },
            ),
            const SizedBox(height: 12),
            const Text(
              "Order Placed Successfully!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("PAYMENT", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Select Delivery Address", style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 2,
              child: paymentProvider.firebaseAddresses.isEmpty
                  ? const Center(child: Text("No addresses saved yet.\nPlease add one from 'Add Address' page.", style: TextStyle(color: Colors.white54), textAlign: TextAlign.center))
                  : ListView.builder(
                itemCount: paymentProvider.firebaseAddresses.length,
                itemBuilder: (context, index) {
                  final address = paymentProvider.firebaseAddresses[index];
                  return Card(
                    color: Colors.grey[900],
                    child: RadioListTile<AddressModel>(
                      activeColor: Colors.teal,
                      title: Text(address.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text("${address.street}, ${address.city}, ${address.state}, ${address.zipCode}\nPhone: ${address.phone}", style: const TextStyle(color: Colors.white70)),
                      value: address,
                      groupValue: paymentProvider.selectedAddress,
                      onChanged: (val) => paymentProvider.selectAddress(val!),
                    ),
                  );
                },
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Select Payment Method", style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Card(
                    color: Colors.grey[900],
                    child: RadioListTile<String>(
                      activeColor: Colors.teal,
                      title: const Text("UPI Payment", style: TextStyle(color: Colors.white)),
                      value: "UPI",
                      groupValue: paymentProvider.selectedPayment,
                      onChanged: (val) => paymentProvider.selectPayment(val!),
                    ),
                  ),
                  Card(
                    color: Colors.grey[900],
                    child: RadioListTile<String>(
                      activeColor: Colors.teal,
                      title: const Text("Cash on Delivery", style: TextStyle(color: Colors.white)),
                      value: "Cash on Delivery",
                      groupValue: paymentProvider.selectedPayment,
                      onChanged: (val) => paymentProvider.selectPayment(val!),
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Order Summary", style: TextStyle(color: Colors.teal, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartProvider.cartItems.keys.toList()[index];
                  final quantity = cartProvider.cartItems.values.toList()[index];
                  return ListTile(
                    leading: product.images != null && product.images!.isNotEmpty
                        ? Image.network(product.images!.first, width: 50)
                        : const Icon(Icons.image, color: Colors.white),
                    title: Text(product.title ?? "No title", style: const TextStyle(color: Colors.white)),
                    subtitle: Text("x$quantity • ₹${(product.price ?? 0) * quantity}", style: const TextStyle(color: Colors.teal)),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total: ₹${cartProvider.totalPrice.toStringAsFixed(2)}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      if (paymentProvider.selectedAddress == null) {
                        Fluttertoast.showToast(
                          msg: "Please Select Delivery Address",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }
                      if (paymentProvider.selectedPayment == null) {
                        Fluttertoast.showToast(
                          msg: "Please Select Payment Method",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        return;
                      }

                      // await paymentProvider.placeOrder(cartProvider);
                      // cartProvider.clearCart();

                      await showOrderSuccessAnimation(context);
                    },
                    child: const Text("CONFIRM ORDER"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pack_bags/pack_it/model/address_model.dart';
import 'package:pack_bags/pack_it/view/root_page.dart';
import 'package:pack_bags/pack_it/view_model/cart_provider.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  AddressModel? _selectedAddress;
  String? _selectedPayment;
  List<AddressModel> firebaseAddresses = [];

  @override
  void initState() {
    super.initState();
    fetchFirebaseAddresses();
  }

  Future<void> fetchFirebaseAddresses() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses')
        .orderBy('timestamp', descending: true)
        .get();

    setState(() {
      firebaseAddresses = snapshot.docs.map((doc) {
        final data = doc.data();
        return AddressModel(
          name: data['name'],
          street: data['street'],
          city: data['city'],
          state: data['state'],
          zipCode: data['zipCode'],
          phone: data['phone'],
        );
      }).toList();
    });
  }

  Future<void> placeOrder(CartProvider cartProvider) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || _selectedAddress == null || _selectedPayment == null) return;

    final orderData = {
      'address': {
        'name': _selectedAddress!.name,
        'street': _selectedAddress!.street,
        'city': _selectedAddress!.city,
        'state': _selectedAddress!.state,
        'zipCode': _selectedAddress!.zipCode,
        'phone': _selectedAddress!.phone,
      },
      'paymentMethod': _selectedPayment,
      'items': cartProvider.cartItems.entries.map((entry) => {
        'productId': entry.key.id,
        'title': entry.key.title,
        'price': entry.key.price,
        'quantity': entry.value,
      }).toList(),
      'total': cartProvider.totalPrice,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('orders')
        .add(orderData);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

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
              child: Text(
                "Select Delivery Address",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: firebaseAddresses.isEmpty
                  ? const Center(
                child: Text(
                  "No addresses saved yet.\nPlease add one from 'Add Address' page.",
                  style: TextStyle(color: Colors.white54),
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView.builder(
                itemCount: firebaseAddresses.length,
                itemBuilder: (context, index) {
                  final address = firebaseAddresses[index];
                  return Card(
                    color: Colors.grey[900],
                    child: RadioListTile<AddressModel>(
                      activeColor: Colors.teal,
                      title: Text(address.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "${address.street}, ${address.city}, ${address.state}, ${address.zipCode}\nPhone: ${address.phone}",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      value: address,
                      groupValue: _selectedAddress,
                      onChanged: (val) {
                        setState(() {
                          _selectedAddress = val;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Card(
                    color: Colors.grey[900],
                    child: RadioListTile<String>(
                      activeColor: Colors.teal,
                      title: const Text("UPI Payment",
                          style: TextStyle(color: Colors.white)),
                      value: "UPI",
                      groupValue: _selectedPayment,
                      onChanged: (val) {
                        setState(() {
                          _selectedPayment = val;
                        });
                      },
                    ),
                  ),
                  Card(
                    color: Colors.grey[900],
                    child: RadioListTile<String>(
                      activeColor: Colors.teal,
                      title: const Text("Cash on Delivery",
                          style: TextStyle(color: Colors.white)),
                      value: "Cash on Delivery",
                      groupValue: _selectedPayment,
                      onChanged: (val) {
                        setState(() {
                          _selectedPayment = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order Summary",
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total: \$${cartProvider.totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      if (_selectedAddress == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select a delivery address")),
                        );
                        return;
                      }
                      if (_selectedPayment == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Please select a payment method")),
                        );
                        return;
                      }

                      // await placeOrder(cartProvider);
                      // cartProvider.clearCart();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Order placed successfully!")),
                      );

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RootPage()),
                      );
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
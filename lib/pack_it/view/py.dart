import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pack_bags/pack_it/view/od.dart';
import 'package:provider/provider.dart';
import 'package:pack_bags/pack_it/model/address_model.dart';
import 'package:pack_bags/pack_it/view_model/cart_provider.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {
  AddressModel? _selectedAddress;
  String? _selectedPayment;
  late Box<AddressModel> _addressBox;

  @override
  void initState() {
    super.initState();
    _addressBox = Hive.box<AddressModel>('addresses');
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
              child: ValueListenableBuilder(
                valueListenable: _addressBox.listenable(),
                builder: (context, Box<AddressModel> box, _) {
                  if (box.values.isEmpty) {
                    return const Center(
                      child: Text(
                        "No addresses saved yet.\nPlease add from 'Add Address' page.",
                        style: TextStyle(color: Colors.white54),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: box.values.length,
                    itemBuilder: (context, index) {
                      final address = box.getAt(index)!;
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
                      title:  Text("Cash on Delivery",
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(color: Colors.white12),
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
                    onPressed: () {
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(
                            deliveryAddress:
                            "${_selectedAddress!.name}, ${_selectedAddress!.street}, ${_selectedAddress!.city}, ${_selectedAddress!.state}, ${_selectedAddress!.zipCode}\nPhone: ${_selectedAddress!.phone}",
                            cartItems: cartProvider.cartItems,
                            totalAmount: cartProvider.totalPrice,
                            paymentMethod: _selectedPayment!,
                          ),
                        ),
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

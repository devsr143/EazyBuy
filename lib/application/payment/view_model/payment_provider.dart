import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../address/model/address_model.dart';
import '../../cart/view_model/cart_provider.dart';

class PaymentProvider with ChangeNotifier {
  AddressModel? selectedAddress;
  String? selectedPayment;
  List<AddressModel> firebaseAddresses = [];

  Future<void> fetchFirebaseAddresses() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('addresses')
        .orderBy('timestamp', descending: true)
        .get();

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

    notifyListeners();
  }

  void selectAddress(AddressModel address) {
    selectedAddress = address;
    notifyListeners();
  }

  void selectPayment(String method) {
    selectedPayment = method;
    notifyListeners();
  }

  Future<void> placeOrder(CartProvider cartProvider) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || selectedAddress == null || selectedPayment == null) return;

    final orderData = {
      'address': {
        'name': selectedAddress!.name,
        'street': selectedAddress!.street,
        'city': selectedAddress!.city,
        'state': selectedAddress!.state,
        'zipCode': selectedAddress!.zipCode,
        'phone': selectedAddress!.phone,
      },
      'paymentMethod': selectedPayment,
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
}
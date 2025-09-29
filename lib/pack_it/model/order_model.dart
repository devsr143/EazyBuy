class Order {
  final String id;
  final String paymentMethod;
  final double total;
  final String address;
  final List<Map<String, dynamic>> items; // product title, price, quantity

  Order({
    required this.id,
    required this.paymentMethod,
    required this.total,
    required this.address,
    required this.items,
  });
}


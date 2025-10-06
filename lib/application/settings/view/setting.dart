import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
import 'package:provider/provider.dart';
import '../../cart/view_model/cart_provider.dart';
import '../widgets/Custom.dart';
import '../../help&support/view/Help&Support.dart';
import '../../privacy/view/Privacypage.dart';
import '../../address/view/address_page.dart';
import '../../order/view/orders.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("SETTINGS"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 25),
        actions: const [
          Icon(Iconsax.setting, color: Colors.white),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                final cartProvider = Provider.of<CartProvider>(context, listen: false);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailsPage(
                      deliveryAddress: "123 Main Street, Kozhikode",
                      cartItems: cartProvider.cartItems,
                      totalAmount: cartProvider.totalPrice,
                      paymentMethod: "Cash on Delivery",
                    ),
                  ),
                );
              },
              child: const CustomContainer(
                title: "Orders",
                icon: Iconsax.bag,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddAddressPage()),
                );
              },
              child: const CustomContainer(
                title: "Address",
                icon: Iconsax.home,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyPage()),
                );
              },
              child: const CustomContainer(
                title: "Privacy policy",
                icon: Iconsax.security,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpPage()),
                );
              },
              child: const CustomContainer(
                title: "Help and support",
                icon: Iconsax.support,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirm Logout"),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Provider.of<AuthenticationProvider>(context, listen: false)
                              .logout(context);
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
              child: const CustomContainer(
                title: "Logout",
                icon: Iconsax.logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




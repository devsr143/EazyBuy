import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/application/settings/view/setting.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import '../../cart/view/cart.dart';
import '../../category/view/catagory.dart';
import '../../Fav/view/fav.dart';
import '../../home/view/home.dart';
import '../../products/view_model/products_provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;
  DateTime? lastPressed; // for double-tap to exit feature

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    _pages = [
      ProductsPage(),
      FavoritesPage(),
      ProductsByCategoryPage(products: productsProvider.products),
      CartPage(),
      SettingsPage(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          Fluttertoast.showToast(
            msg: "Press back again to exit",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.black87,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          return;
        }
        await SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _pages[_selectedIndex],
        bottomNavigationBar: FlashyTabBar(
          backgroundColor: Colors.black,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            FlashyTabBarItem(
              icon: const Icon(Iconsax.home),
              title: const Text('HOME'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.heart),
              title: const Text('FAVORITES'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.category),
              title: const Text('CATEGORY'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.shopping_cart),
              title: const Text('CART'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
            FlashyTabBarItem(
              icon: const Icon(Iconsax.setting),
              title: const Text('SETTINGS'),
              activeColor: Colors.white,
              inactiveColor: Colors.white,
            ),
          ],
        ),
      ),
    );  }
}

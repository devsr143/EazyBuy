import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/pack_it/view/cart.dart';
import 'package:pack_bags/pack_it/view/catagory.dart';
import 'package:pack_bags/pack_it/view/fav.dart';
import 'package:pack_bags/pack_it/view/home.dart';
import 'package:pack_bags/pack_it/view/setting.dart';
import 'package:pack_bags/pack_it/view_model/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

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

    return Scaffold(
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
            icon: Icon(Iconsax.home),
            title: Text('HOME'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: Icon(Iconsax.heart),
            title: Text('FAVORITES'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: Icon(Iconsax.category),
            title: Text('CATEGORY'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: Icon(Iconsax.shopping_cart),
            title: Text('CART'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          FlashyTabBarItem(
            icon: Icon(Iconsax.setting),
            title: Text('SETTINGS'),
            activeColor: Colors.white,
            inactiveColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pack_bags/pack_it/view/cart.dart';
import 'package:pack_bags/pack_it/view/catagory.dart';
import 'package:pack_bags/pack_it/view/fav.dart';
import 'package:pack_bags/pack_it/view/home.dart';
import 'package:pack_bags/pack_it/view/setting.dart';
import 'package:pack_bags/pack_it/view_model/products_provider.dart';
import 'package:provider/provider.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Iconsax.home,color: Colors.white,), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Iconsax.heart,color: Colors.white,), label: 'FAV'),
          BottomNavigationBarItem(icon: Icon(Iconsax.category,color: Colors.white,), label: 'Cat'),
          BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart,color: Colors.white,), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Iconsax.setting,color: Colors.white,), label: 'Profile'),
        ],
      ),
    );
  }
}

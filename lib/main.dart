import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pack_bags/firebase_options.dart';
import 'package:pack_bags/pack_it/model/address_model.dart';
import 'package:pack_bags/pack_it/view/root_page.dart';
import 'package:pack_bags/pack_it/view_model/cart_provider.dart';
import 'package:pack_bags/pack_it/view_model/catogary_provider.dart';
import 'package:pack_bags/pack_it/view_model/fav_provider.dart';
import 'package:provider/provider.dart';
import 'pack_it/view_model/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox<AddressModel>('addresses');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:  RootPage(),
    );
  }
}
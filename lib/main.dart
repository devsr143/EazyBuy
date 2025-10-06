
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pack_bags/application/auth/view/Login.dart';
import 'package:pack_bags/application/auth/view/Signup.dart';
import 'package:pack_bags/application/auth/view_model/auth_provider.dart';
import 'package:pack_bags/firebase_options.dart';
import 'package:provider/provider.dart';

import 'application/pack_it/model/address_model.dart';
import 'application/pack_it/view/OnboardingScreen.dart';
import 'application/pack_it/view/root_page.dart';
import 'application/pack_it/view_model/cart_provider.dart';
import 'application/pack_it/view_model/catogary_provider.dart';
import 'application/pack_it/view_model/fav_provider.dart';
import 'application/pack_it/view_model/products_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  Hive.registerAdapter(AddressModelAdapter());
  await Hive.openBox<AddressModel>('addresses');

  final box = await Hive.openBox('app');
  final bool isFirstTime = box.get('isFirstTime', defaultValue: true);

  final User? user = FirebaseAuth.instance.currentUser;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pack Bags',
        // Set initial screen logic
        initialRoute: isFirstTime
            ? '/onboarding'
            : (user != null ? '/root' : '/'),
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/': (context) => const LoginScreen(),
          '/signup': (context) => const CreateAccountScreen(),
          '/root': (context) => const RootPage(),
        },
      ),
    ),
  );
}

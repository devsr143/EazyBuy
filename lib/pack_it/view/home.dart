import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pack_bags/pack_it/view/product_detils_page.dart';
import 'package:pack_bags/pack_it/view_model/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:pack_bags/pack_it/model/products_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  File? _imageFile;
  String? firstName;
  String? lastName;
  String? email;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      setState(() {
        firstName = doc['firstName'];
        lastName = doc['lastName'];
        email = doc['email'];
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      // Optional: Upload to Firebase Storage and save URL to Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blueGrey,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage("assets/ad banner/SEO.jpeg") as ImageProvider,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${firstName ?? ''} ${lastName ?? ''}',
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  email ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : provider.errorMessage != null
          ? Center(child: Text(provider.errorMessage!, style: const TextStyle(color: Colors.white)))
          : provider.filteredProducts.isEmpty
          ? const Center(child: Text('No products found', style: TextStyle(color: Colors.white)))
          : CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: provider.searchProducts,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 120,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.85,
                  aspectRatio: 2.0,
                  autoPlayInterval: const Duration(seconds: 3),
                ),
                items: [
                  "assets/ad banner/shoes.jpg",
                  "assets/ad banner/jeans.jpg",
                  "assets/ad banner/newa rrival.jpg",
                ].map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final product = provider.filteredProducts[index];
                  return ProductCard(product: product);
                },
                childCount: provider.filteredProducts.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductsModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(product: product),
          ),
        );
      },
      child: Card(
        color: Colors.white70,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: product.images != null && product.images!.isNotEmpty
                    ? Image.network(
                  product.images!.first,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
                    : Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title ?? 'No Title',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${product.price?.toString() ?? '0'}',
                style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.teal),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
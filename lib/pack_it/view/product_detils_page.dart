import 'package:flutter/material.dart';
import 'package:pack_bags/pack_it/model/products_model.dart';
import 'package:pack_bags/pack_it/view_model/fav_provider.dart';
import 'package:pack_bags/pack_it/view_model/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductsModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  List<String> availableSizes = ['S', 'M', 'L', 'XL'];
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoritesProvider.isFavorite(widget.product);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.product.title ?? 'Product Details',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.product.images != null &&
                widget.product.images!.isNotEmpty)
              Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 400,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: widget.product.images!.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.product.images![index],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: isFav ? Colors.red : Colors.white,
                            size: 32,
                          ),
                          onPressed: () {
                            favoritesProvider.toggleFavorite(widget.product);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isFav
                                      ? 'Removed from Favorites'
                                      : 'Added to Favorites',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.product.images!.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentIndex == index ? 12 : 8,
                        height: _currentIndex == index ? 12 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.teal
                              : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              Container(
                height: 250,
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 80),
              ),

            const SizedBox(height: 16),
            Text(
              widget.product.title ?? 'No Title',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price?.toString() ?? '0'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),

            DropdownButton<String>(
              value: selectedSize,
              dropdownColor: Colors.black,
              hint: const Text('Choose a size', style: TextStyle(color: Colors.white70)),
              iconEnabledColor: Colors.white,
              items: availableSizes.map((size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size, style: const TextStyle(color: Colors.white)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSize = value;
                });
              },
            ),

            const SizedBox(height: 16),
            if (widget.product.category != null)
              Row(
                children: [
                  const Text(
                    'Category: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    widget.product.category!.name ?? 'Unknown',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),

            const SizedBox(height: 16),
            Text(
              widget.product.description ?? 'No Description',
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),

            const SizedBox(height: 24),
            Text(
              'Select Size',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 60,
          margin: const EdgeInsets.all(12),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if (selectedSize == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please select a size'),
                    duration: Duration(seconds: 1),
                  ),
                );
                return;
              }

              Provider.of<CartProvider>(context, listen: false)
                  .addToCart(widget.product /*, selectedSize if needed */);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to Cart'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const Text(
              "ADD TO CART",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
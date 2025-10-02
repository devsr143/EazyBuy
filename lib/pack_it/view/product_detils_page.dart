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

  // Selections
  String? selectedSize; // Clothes & Shoes
  String? selectedModel; // Furniture
  String? selectedVariant; // Electronics

  double? userRating;

  // Options
  List<String> sizes = ['S', 'M', 'L', 'XL'];
  List<String> shoeSizes = ['6', '7', '8', '9', '10'];
  List<String> models = ['Model A', 'Model B', 'Model C'];
  List<String> variants = ['Red', 'Blue', 'Black'];

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final isFav = favoritesProvider.isFavorite(widget.product);

    // Determine product type
    final category = widget.product.category?.name?.toLowerCase();
    bool isClothes = category == 'clothes';
    bool isShoes = category == 'shoes';
    bool isFurniture = category == 'furniture';
    bool isElectronics = category == 'electronics';

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
            // Images
            if (widget.product.images != null && widget.product.images!.isNotEmpty)
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
                                content: Text(isFav ? 'Removed from Favorites' : 'Added to Favorites'),
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
                          color: _currentIndex == index ? Colors.teal : Colors.white54,
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
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${widget.product.price?.toString() ?? '0'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.teal),
            ),
            const SizedBox(height: 16),

            // Dynamic selection based on category
            if (isClothes) ...[
              const Text('Select Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: sizes.map((size) {
                  bool isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () => setState(() => selectedSize = size),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.transparent,
                        border: Border.all(color: isSelected ? Colors.teal : Colors.white54, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else if (isShoes) ...[
              const Text('Select Shoe Size', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: shoeSizes.map((size) {
                  bool isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () => setState(() => selectedSize = size),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.transparent,
                        border: Border.all(color: isSelected ? Colors.teal : Colors.white54, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        size,
                        style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else if (isFurniture) ...[
              const Text('Select Model', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: models.map((model) {
                  bool isSelected = selectedModel == model;
                  return GestureDetector(
                    onTap: () => setState(() => selectedModel = model),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.transparent,
                        border: Border.all(color: isSelected ? Colors.teal : Colors.white54, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        model,
                        style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ] else if (isElectronics) ...[
              const Text('Select Variant', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 10),
              Row(
                children: variants.map((variant) {
                  bool isSelected = selectedVariant == variant;
                  return GestureDetector(
                    onTap: () => setState(() => selectedVariant = variant),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.teal : Colors.transparent,
                        border: Border.all(color: isSelected ? Colors.teal : Colors.white54, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        variant,
                        style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.white70),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            const SizedBox(height: 16),
            const Text("Rate this Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      userRating = (index + 1).toDouble();
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("You rated this ${index + 1} ⭐"), duration: const Duration(seconds: 1)),
                    );
                  },
                  child: Icon(
                    index < (userRating ?? 0) ? Icons.star : Icons.star_border,
                    color: Colors.orangeAccent,
                    size: 28,
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),
            if (widget.product.category != null)
              Row(
                children: [
                  const Text('CATEGORY: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(widget.product.category!.name ?? 'Unknown', style: const TextStyle(color: Colors.white)),
                ],
              ),
            const SizedBox(height: 16),
            Text(widget.product.description ?? 'No Description', style: const TextStyle(fontSize: 16, color: Colors.white)),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // Validate selection based on product type
              if ((isClothes && selectedSize == null) ||
                  (isShoes && selectedSize == null) ||
                  (isFurniture && selectedModel == null) ||
                  (isElectronics && selectedVariant == null)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please make a selection'), duration: Duration(seconds: 1)),
                );
                return;
              }

              Provider.of<CartProvider>(context, listen: false).addToCart(widget.product);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to Cart'), duration: Duration(seconds: 1)),
              );
            },
            child:  Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Icon(Icons.shopping_cart,color: Colors.white,),
              Text("ADD TO CART", style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))]),
          ),
        ),
      ),
    );
  }
}
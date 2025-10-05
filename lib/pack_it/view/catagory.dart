import 'package:flutter/material.dart';
import 'package:pack_bags/pack_it/model/products_model.dart';
import 'package:pack_bags/pack_it/view/product_detils_page.dart';

class ProductsByCategoryPage extends StatefulWidget {
  final List<ProductsModel> products;

  const ProductsByCategoryPage({super.key, required this.products});

  @override
  State<ProductsByCategoryPage> createState() => _ProductsByCategoryPageState();
}

class _ProductsByCategoryPageState extends State<ProductsByCategoryPage> {
  late List<String> categories;
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    categories = widget.products
        .map((p) => p.category?.name ?? '')
        .toSet()
        .where((name) => name.isNotEmpty)
        .toList();
    categories.sort();
    categories.insert(0, 'All');
    selectedCategory = 'All';
  }

  List<ProductsModel> get filteredProducts {
    if (selectedCategory == 'All') return widget.products;
    return widget.products
        .where((p) => p.category?.name == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'CATEGORY',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Row(
        children: [
          // Left category list
          Container(
            width: 150,
            color: Colors.transparent,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.teal[300] : Colors.white24,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        cat,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Colors.white54,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Right product grid
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(
                child: Text('No products found',
                    style: TextStyle(color: Colors.white)))
                : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                itemCount: filteredProducts.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailsPage(product: product),
                        ),
                      );
                    },
                    child: ProductCard(product: product),
                  );
                },
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
    return Card(
      color: Colors.white70,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(12)),
              child: product.images != null && product.images!.isNotEmpty
                  ? Image.network(
                product.images!.first,
                fit: BoxFit.cover,
                width: double.infinity,
              )
                  : Container(
                color: Colors.white12,
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.title ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${product.price ?? 0}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

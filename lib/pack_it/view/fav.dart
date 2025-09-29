import 'package:flutter/material.dart';
import 'package:pack_bags/pack_it/view/product_detils_page.dart';
import 'package:pack_bags/pack_it/view_model/fav_provider.dart';
import 'package:provider/provider.dart';
import 'package:pack_bags/pack_it/model/products_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesProvider>(context).favorites;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("MY FAVORITES",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
      ),
      body: favorites.isEmpty
          ? const Center(
        child: Text(
          "No favorites added yet",
          style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.w500),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // two items per row
          childAspectRatio: 0.7, // card aspect ratio
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          ProductsModel product = favorites[index];

          return GestureDetector(
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: product.images != null &&
                        product.images!.isNotEmpty
                        ? Image.network(
                      product.images![0],
                      height: 140,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      height: 140,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.title ?? 'No Title',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "\$${product.price ?? 0}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 8, right: 8, bottom: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

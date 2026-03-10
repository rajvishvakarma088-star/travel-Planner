import 'package:flutter/material.dart';
import '../services/trip_service.dart';
import 'place_detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  void deleteWishlist(String name) async {
  await TripService.removeWishlist(name);
  loadWishlist();
}

  List<Map<String, String>> wishlist = [];

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }

  void loadWishlist() async {
    final data = await TripService.getWishlist();
    setState(() {
      wishlist = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return wishlist.isEmpty
        ? const Center(child: Text("No items in wishlist"))
        : ListView.builder(
            itemCount: wishlist.length,

            itemBuilder: (context, index) {

              final place = wishlist[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                child: ListTile(

  leading: Image.network(
    place["image"]!,
    width: 50,
    fit: BoxFit.cover,
  ),

  title: Text(place["name"]!),

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreen(
          name: place["name"]!,
          imageUrl: place["image"]!,
          city: place["city"]!,
        ),
      ),
    );
  },

  trailing: IconButton(
    icon: const Icon(Icons.delete, color: Colors.red),
    onPressed: () {
      deleteWishlist(place["name"]!);
    },
  ),
),
              );
            },
          );
  }
}
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripService {

  static const tripsKey = "trips";
  static const wishlistKey = "wishlist";

  // Save Trip
  static Future<void> saveTrip(Map<String, String> trip) async {
    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(tripsKey) ?? [];

    trips.add(jsonEncode(trip));

    await prefs.setStringList(tripsKey, trips);
  }

  // Get Trips
  static Future<List<Map<String, String>>> getTrips() async {
    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(tripsKey) ?? [];

    return trips
        .map((trip) => Map<String, String>.from(jsonDecode(trip)))
        .toList();
  }

  // Remove Trip
  static Future<void> removeTrip(String name) async {
    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(tripsKey) ?? [];

    trips.removeWhere((trip) {
      final data = jsonDecode(trip);
      return data["name"] == name;
    });

    await prefs.setStringList(tripsKey, trips);
  }

  // Save Wishlist
  static Future<void> saveWishlist(Map<String, String> place) async {
    final prefs = await SharedPreferences.getInstance();

    final wishlist = prefs.getStringList(wishlistKey) ?? [];

    wishlist.add(jsonEncode(place));

    await prefs.setStringList(wishlistKey, wishlist);
  }

  // Get Wishlist
  static Future<List<Map<String, String>>> getWishlist() async {
    final prefs = await SharedPreferences.getInstance();

    final wishlist = prefs.getStringList(wishlistKey) ?? [];

    return wishlist
        .map((item) => Map<String, String>.from(jsonDecode(item)))
        .toList();
  }

  static Future<void> removeWishlist(String name) async {
  final prefs = await SharedPreferences.getInstance();

  final wishlist = prefs.getStringList(wishlistKey) ?? [];

  wishlist.removeWhere((item) {
    final data = jsonDecode(item);
    return data["name"] == name;
  });

  await prefs.setStringList(wishlistKey, wishlist);
}

}
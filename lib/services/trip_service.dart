import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TripService {

  static const String key = "savedTrips";

  // Save trip
  static Future<void> saveTrip(Map<String, String> trip) async {
    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(key) ?? [];

    trips.add(jsonEncode(trip));

    await prefs.setStringList(key, trips);
  }

  // Get trips
  static Future<List<Map<String, String>>> getTrips() async {
    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(key) ?? [];

    return trips
        .map((trip) => Map<String, String>.from(jsonDecode(trip)))
        .toList();
  }

  // Remove trip
  static Future<void> removeTrip(String name) async {

    final prefs = await SharedPreferences.getInstance();

    final trips = prefs.getStringList(key) ?? [];

    trips.removeWhere((trip) {
      final data = jsonDecode(trip);
      return data["name"] == name;
    });

    await prefs.setStringList(key, trips);
  }
}
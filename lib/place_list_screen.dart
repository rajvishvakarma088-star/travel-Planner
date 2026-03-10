import 'package:flutter/material.dart';
import 'place_detail_screen.dart';

class PlaceListScreen extends StatelessWidget {
  final String city;

  const PlaceListScreen({super.key, required this.city});

  // Map database
  static final Map<String, List<Map<String, String>>> placesData = {

    "Goa": [
      {
        "name": "Baga Beach",
        "image":
            "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800"
      },
      {
        "name": "Fort Aguada",
        "image":
            "https://images.unsplash.com/photo-1593693397690-362cb9666fc2?w=800"
      },
      {
        "name": "Calangute Beach",
        "image":
            "https://images.unsplash.com/photo-1519046904884-53103b34b206?w=800"
      },
    ],

    "Paris": [
      {
        "name": "Eiffel Tower",
        "image":
            "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800"
      },
      {
        "name": "Louvre Museum",
        "image":
            "https://images.unsplash.com/photo-1565099824688-e93eb20fe622?w=800"
      },
      {
        "name": "Notre Dame",
        "image":
            "https://images.unsplash.com/photo-1508057198894-247b23fe5ade?w=800"
      },
    ],

    "Agra": [
      {
        "name": "Taj Mahal",
        "image":
            "https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800"
      },
      {
        "name": "Agra Fort",
        "image":
            "https://images.unsplash.com/photo-1609947017136-9daf32a5eb16?w=800"
      },
      {
        "name": "Mehtab Bagh",
        "image":
            "https://images.unsplash.com/photo-1587135991058-8816c8d10fca?w=800"
      },
    ],

    "Manali": [
      {
        "name": "Solang Valley",
        "image":
            "https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800"
      },
      {
        "name": "Rohtang Pass",
        "image":
            "https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800"
      },
      {
        "name": "Hadimba Temple",
        "image":
            "https://images.unsplash.com/photo-1609947017136-9daf32a5eb16?w=800"
      },
    ],

    "Tokyo": [
      {
        "name": "Shibuya Crossing",
        "image":
            "https://images.unsplash.com/photo-1549692520-acc6669e2f0c?w=800"
      },
      {
        "name": "Tokyo Tower",
        "image":
            "https://images.unsplash.com/photo-1505066836043-7b6a5c0df3c5?w=800"
      },
      {
        "name": "Sensoji Temple",
        "image":
            "https://images.unsplash.com/photo-1554797589-7241bb691973?w=800"
      },
    ],

    "London": [
      {
        "name": "Big Ben",
        "image":
            "https://images.unsplash.com/photo-1505761671935-60b3a7427bad?w=800"
      },
      {
        "name": "London Eye",
        "image":
            "https://images.unsplash.com/photo-1509099836639-18ba1795216d?w=800"
      },
      {
        "name": "Tower Bridge",
        "image":
            "https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=800"
      },
    ],

    "Dubai": [
      {
        "name": "Burj Khalifa",
        "image":
            "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800"
      },
      {
        "name": "Palm Jumeirah",
        "image":
            "https://images.unsplash.com/photo-1580674285054-bed31e145f59?w=800"
      },
      {
        "name": "Dubai Marina",
        "image":
            "https://images.unsplash.com/photo-1518684079-3c830dcef090?w=800"
      },
    ],

    "New York": [
      {
        "name": "Statue of Liberty",
        "image":
            "https://images.unsplash.com/photo-1534447677768-be436bb09401?w=800"
      },
      {
        "name": "Central Park",
        "image":
            "https://images.unsplash.com/photo-1508261305437-cc4f24e0cbb5?w=800"
      },
      {
        "name": "Times Square",
        "image":
            "https://images.unsplash.com/photo-1501917827284-6a0a7e5c8c5c?w=800"
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    final places = placesData[city] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("$city Places"),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: places.length,

        itemBuilder: (context, index) {
          final place = places[index];

          return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaceDetailScreen(
          name: place["name"]!,
          imageUrl: place["image"]!,
          city: city,
        ),
      ),
    );
  },

  child: Container(
    margin: const EdgeInsets.only(bottom: 16),
    height: 180,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      image: DecorationImage(
        image: NetworkImage(place["image"]!),
        fit: BoxFit.cover,
      ),
    ),

    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withValues(alpha: 0.35),
      ),

      child: Align(
        alignment: Alignment.bottomLeft,

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Text(
            place["name"]!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  ),
);
        },
      ),
    );
  }
}
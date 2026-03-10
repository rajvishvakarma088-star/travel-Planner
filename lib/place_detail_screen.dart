import 'package:flutter/material.dart';
import 'services/weather_service.dart';
import 'services/trip_service.dart';

class PlaceDetailScreen extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String city;

  final WeatherService weatherService = WeatherService();

  PlaceDetailScreen({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.city,
  });


  List<String> getItinerary() {

  if (name.toLowerCase().contains("beach")) {
    return [
      "Day 1: Relax at the beach",
      "Day 2: Water sports and sunset view",
      "Day 3: Beachside cafes and shopping"
    ];
  }

  if (city.toLowerCase() == "manali") {
    return [
      "Day 1: Explore Manali Mall Road",
      "Day 2: Visit Solang Valley",
      "Day 3: Rohtang Pass adventure"
    ];
  }

  if (city.toLowerCase() == "agra") {
    return [
      "Day 1: Visit Taj Mahal",
      "Day 2: Explore Agra Fort",
      "Day 3: Local markets and food"
    ];
  }

  if (city.toLowerCase() == "paris") {
    return [
      "Day 1: Eiffel Tower and Seine cruise",
      "Day 2: Louvre Museum",
      "Day 3: Shopping and cafes"
    ];
  }

  return [
    "Day 1: Arrival and city exploration",
    "Day 2: Visit famous attractions",
    "Day 3: Local food and shopping"
  ];
}

  @override
  Widget build(BuildContext context) {

    final itinerary = getItinerary();

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2196F3),
                Color.fromARGB(255, 213, 229, 248)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // Place Image
            Container(
              height: 250,
              width: double.infinity,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  // Place Title
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Description
                  const Text(
                    "This beautiful destination is famous for its scenic views, culture, and amazing tourist attractions. Travelers from all around the world visit here to experience its beauty and history.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Weather Card
                  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16),

  child: FutureBuilder(
  future: weatherService.getWeather(city),
  builder: (context, snapshot) {

    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return const Text("Failed to load weather");
    }

    final data = snapshot.data as Map<String, dynamic>;

    final temp = data["main"]["temp"];
    final condition = data["weather"][0]["main"];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blue.withValues(alpha: 0.1),
      ),
      child: Row(
        children: [

          const Icon(Icons.cloud, size: 40, color: Colors.blue),

          const SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Temperature: ${temp.toStringAsFixed(1)}°C"),
              Text("Condition: $condition"),
            ],
          )
        ],
      ),
    );
  },
)
),

       const SizedBox(height: 25),

const Text(
  "Travel Itinerary",
  style: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  ),
),

const SizedBox(height: 10),

Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: Colors.green.withValues(alpha: 0.1),
  ),

  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: itinerary.map((day) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.green),
            const SizedBox(width: 10),
            Expanded(child: Text(day)),
          ],
        ),
      );
    }).toList(),
  ),
),

const SizedBox(height: 25),

                  // Save Trip Button
                 Row(
  children: [

    // Wishlist Button
    Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.favorite_border),
        label: const Text("Wishlist"),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 248, 154, 185),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),

        onPressed: () async {

          await TripService.saveWishlist({
  "name": name,
  "image": imageUrl,
  "city": city,
});

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Added to Wishlist ❤️"),
            ),
          );
        },
      ),
    ),

    const SizedBox(width: 10),

    // Save Trip Button
    Expanded(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.map),
        label: const Text("Save Trip"),

        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 159, 206, 245),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),

        onPressed: () async {

          await TripService.saveTrip({
            "name": name,
            "image": imageUrl,
            "city": city,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Trip saved successfully!"),
            ),
          );
        },
      ),
    ),

  ],
),

                  const SizedBox(height: 20),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
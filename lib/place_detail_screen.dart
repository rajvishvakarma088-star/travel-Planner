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

  @override
  Widget build(BuildContext context) {
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

                  // Save Trip Button
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.blue,
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

                      child: const Text(
                        "Save to My Trips",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
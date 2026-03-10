import 'package:flutter/material.dart';
import '../services/trip_service.dart';
import 'place_detail_screen.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {

  List<Map<String, String>> trips = [];

  @override
  void initState() {
    super.initState();
    loadTrips();
  }

  void loadTrips() async {
    final data = await TripService.getTrips();
    setState(() {
      trips = data;
    });
  }

  @override
  Widget build(BuildContext context) {

    return trips.isEmpty
        ? const Center(
            child: Text(
              "No trips planned yet",
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: trips.length,
            itemBuilder: (context, index) {

              final trip = trips[index];

              return GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(
                        name: trip["name"]!,
                        imageUrl: trip["image"]!,
                        city: trip["city"]!,
                      ),
                    ),
                  );

                },

                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,

                  child: Stack(
                    children: [

                      Image.network(
                        trip["image"]!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      Container(
                        height: 200,
                        color: Colors.black.withValues(alpha: 0.35),
                      ),

                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Text(
                          trip["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
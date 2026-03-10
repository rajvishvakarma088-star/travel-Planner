import 'package:flutter/material.dart';
import '../services/trip_service.dart';
import 'place_detail_screen.dart';

class SavedTripsScreen extends StatefulWidget {
  const SavedTripsScreen({super.key});

  @override
  State<SavedTripsScreen> createState() => _SavedTripsScreenState();
}

class _SavedTripsScreenState extends State<SavedTripsScreen> {

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

  void deleteTrip(String place) async {
    await TripService.removeTrip(place);
    loadTrips();
  }

  @override
  Widget build(BuildContext context) {

    return trips.isEmpty
        ? const Center(child: Text("No trips saved yet"))
        : ListView.builder(
            itemCount: trips.length,

            itemBuilder: (context, index) {

              final trip = trips[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                child: ListTile(

                  leading: Image.network(
                    trip["image"]!,
                    width: 50,
                    fit: BoxFit.cover,
                  ),

                  title: Text(trip["name"]!),

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

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      deleteTrip(trip["name"]!);
                    },
                  ),
                ),
              );
            },
          );
  }
}
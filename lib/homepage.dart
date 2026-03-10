import 'package:flutter/material.dart';
import 'place_list_screen.dart';
import 'wishlist.dart';
import 'trip_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<String> pageTitles = [
  "Smart Travel Planner",
  "Trips",
  "Saved Trips",
  "Profile",
];

class _HomePageState extends State<HomePage> {





  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
  centerTitle: true,

   title: SvgPicture.asset(
  "assets/finalLogo.svg",
  height: 35,
),

  actions: const [
    Padding(
      padding: EdgeInsets.only(right: 12),
      child: CircleAvatar(
        backgroundImage: NetworkImage(
          "https://media.licdn.com/dms/image/v2/D4E03AQH7llf35jQF9w/profile-displayphoto-crop_800_800/B4EZzEgfbSH0AI-/0/1772823379012?e=1774483200&v=beta&t=6PWYZB63pc2sEn0wCMFdZfHhoCMz5OVjcMys0drl3CI",
        ),
      ),
    )
  ],

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

     body: selectedIndex == 0
    ? homeContent()
    : selectedIndex == 1
        ? const TripScreen()
        : selectedIndex == 2
            ? const WishlistScreen()
            : const ProfileScreen(),

      bottomNavigationBar: NavigationBar(

        selectedIndex: selectedIndex,

        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.map), label: "Trips"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Wishlist"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget homeContent() {

    return Padding(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          const Text(
            "Welcome, Raj!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          TextField(
            decoration: InputDecoration(
              hintText: "Search destinations...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Popular Destinations",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: GridView.count(

              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,

              children: const [

                DestinationCard(
                  name: "Goa",
                  imageUrl:
                      "https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?w=800",
                ),

                DestinationCard(
                  name: "Paris",
                  imageUrl:
                      "https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=800",
                ),

                DestinationCard(
                  name: "Agra",
                  imageUrl:
                      "https://images.unsplash.com/photo-1564507592333-c60657eea523?w=800",
                ),

                DestinationCard(
                  name: "Manali",
                  imageUrl:
                      "https://images.unsplash.com/photo-1626621341517-bbf3d9990a23?w=800",
                ),

                DestinationCard(
                  name: "Tokyo",
                  imageUrl:
                      "https://images.unsplash.com/photo-1549692520-acc6669e2f0c?w=800",
                ),

                DestinationCard(
                  name: "London",
                  imageUrl:
                      "https://images.unsplash.com/photo-1505761671935-60b3a7427bad?w=800",
                ),

                DestinationCard(
                  name: "Dubai",
                  imageUrl:
                      "https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=800",
                ),

                DestinationCard(
                  name: "New York",
                  imageUrl:
                      "https://images.unsplash.com/photo-1534430480872-3498386e7856?w=800",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {

  final String name;
  final String imageUrl;

  const DestinationCard({
    super.key,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaceListScreen(city: name),
          ),
        );
      },

      child: Card(
        elevation: 4,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),

        clipBehavior: Clip.antiAlias,

        child: Stack(

          children: [

            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ),

            Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
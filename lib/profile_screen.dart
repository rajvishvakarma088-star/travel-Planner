import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLoggedIn", false);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://media.licdn.com/dms/image/v2/D4E03AQH7llf35jQF9w/profile-displayphoto-crop_800_800/B4EZzEgfbSH0AI-/0/1772823379012?e=1774483200&v=beta&t=6PWYZB63pc2sEn0wCMFdZfHhoCMz5OVjcMys0drl3CI",
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Raj Vishvakarma",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "rajvishvakarma@gmail.com",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),

              onPressed: () => logout(context),
            ),

          ],
        ),
      ),
    );
  }
}
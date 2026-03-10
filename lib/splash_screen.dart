import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {

    final prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );

    } else {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body: Center(
        child: Text(
          "Smart Travel Planner",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
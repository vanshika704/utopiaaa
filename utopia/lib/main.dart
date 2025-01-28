import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:utopia/pages/Login.dart';
import 'package:utopia/pages/Page2.dart';
import 'package:utopia/pages/page1.dart';
import 'package:utopia/pages/page3.dart';
import 'package:utopia/pages/splash.dart'; // Import GetX

void main() async {
  try {
    // Load the .env file
    await dotenv.load();
    print("Environment variables loaded successfully!");
  } catch (e) {
    print("Error loading environment variables: $e");
  }

  // Proceed to run the app
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define your routes
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash', // Initial route
      getPages: [
        GetPage(name: '/splash', page: () => Splash()), // Splash screen route
        GetPage(name: '/home', page: () => Page1()), // Home screen route
         GetPage(name: '/Page2', page: () => SignupPage()),
          GetPage(name: '/Page3', page: () => VoiceButtonPage()),
           GetPage(name: '/login', page: () => LoginPage()),
      ],
    );
  }
}

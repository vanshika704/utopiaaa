
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'page3.dart'; // Import Page3 if it's not using named routes

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // Function to handle login
//   Future<void> loginUser() async {
//     final String apiUrl = "https://utopiaa-rqkd.onrender.com/api/users/login"; // Replace with your local IP

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "email": emailController.text,
//           "password": passwordController.text,
//         }),
//       );

//       // Debugging: Log the response status and body
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.body}");

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         // Show success message
//         Get.snackbar(
//           "Login Successful",
//           "Welcome back, ${data['user']['name']}!",
//           snackPosition: SnackPosition.BOTTOM,
//         );

//         // Log user info to the console
//         print("User logged in: ${data['user']}");

//         // Navigate to Page3 (Pass user data if necessary)
//         Get.off(VoiceButtonPage()); // Navigate to Page3 and pass user data

//       } else {
//         // Handle errors better
//         final error = jsonDecode(response.body)['message'];
//         Get.snackbar(
//           "Login Failed",
//           error,
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       // Show detailed error message if something goes wrong
//       print("Error: $e");
//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(251, 217, 197, 1),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 25),
//                   Image.asset(
//                     'assets/istockphoto-1353464216-612x612 1 (3).png',
//                     width: screenWidth * 0.9,
//                     height: MediaQuery.of(context).size.height * 0.4,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 50),
//                   buildTextField(emailController, "Email", Icons.email),
//                   const SizedBox(height: 16.0),
//                   buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
//                   const SizedBox(height: 75.0),
//                   ElevatedButton(
//                     onPressed: loginUser,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4A2D26),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
                      
//                       padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
//                     ),
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(color: Colors.white , fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: screenWidth * 0.50,
//               height: 4,
//               margin: const EdgeInsets.only(bottom: 6),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 0, 0, 0),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword,
//         decoration: InputDecoration(
//           labelText: label,
//           prefixIcon: Icon(icon),
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(30.0),
//             borderSide: BorderSide.none,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences
import 'page3.dart'; // Import Page3 if it's not using named routes

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Function to handle login
  Future<void> loginUser() async {
    final String apiUrl = "https://utopiaa-rqkd.onrender.com/api/users/login"; // Replace with your local IP

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      // Debugging: Log the response status and body
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Store unique code in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("uniqueCode", data['user']['uniqueCode']);
        print("Unique Code Saved: ${data['user']['uniqueCode']}");

        // Show success message
        Get.snackbar(
          "Login Successful",
          "Welcome back, ${data['user']['name']}!",
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to Page3 (Pass user data if necessary)
        Get.off(VoiceButtonPage()); // Navigate to Page3

      } else {
        // Handle errors better
        final error = jsonDecode(response.body)['message'];
        Get.snackbar(
          "Login Failed",
          error,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Show detailed error message if something goes wrong
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(251, 217, 197, 1),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  Image.asset(
                    'assets/istockphoto-1353464216-612x612 1 (3).png',
                    width: screenWidth * 0.9,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 50),
                  buildTextField(emailController, "Email", Icons.email),
                  const SizedBox(height: 16.0),
                  buildTextField(passwordController, "Password", Icons.lock, isPassword: true),
                  const SizedBox(height: 75.0),
                  ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A2D26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white , fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: screenWidth * 0.50,
              height: 4,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon, {bool isPassword = false}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'page3.dart';  // Import your Page3 widget

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? uniqueCode;

  // Function to handle signup
  Future<void> signupUser() async {
    final String apiUrl = "https://utopiaa-rqkd.onrender.com/api/users/signup"; // Replace with your local IP

    // Validate the input fields
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      Get.snackbar("Validation Error", "Name, email, and password are required.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "password": passwordController.text, // Ensure password is used here
        }),
      );

      // Log the response status and body for debugging
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        setState(() {
          uniqueCode = data['user']['uniqueCode'];
        });

        // Show success message with unique code
        Get.snackbar("Signup Successful", "Your Unique Code: $uniqueCode");

        // Show the unique code in a modal dialog
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Your Unique Code"),
            content: Text("Your Unique Code is: $uniqueCode"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the modal
                  Get.off(VoiceButtonPage()); // Navigate to Page3
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
        // Log user info to the console
        print("User registered: ${data['user']}");
      } else {
        final error = jsonDecode(response.body)['message'];
        Get.snackbar("Signup Failed", error);
      }
    } catch (e) {
      // Log the error if something goes wrong with the request
      print("Error: $e");
      Get.snackbar("Signup Failed", "An error occurred. Please try again.");
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 50),
                  buildTextField(nameController, "Name", Icons.person),
                  const SizedBox(height: 16.0),
                  buildTextField(emailController, "Email", Icons.email),
                  const SizedBox(height: 16.0),
                  buildTextField(passwordController, "Password", Icons.password), // Ensure password is here
                  const SizedBox(height: 25.0),
                  ElevatedButton(
                    onPressed: signupUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A2D26),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 12.0),
                    ),
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  if (uniqueCode != null) ...[ 
                    const SizedBox(height: 20),
                    Text(
                      "Your Unique Code: $uniqueCode",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
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

  Widget buildTextField(TextEditingController controller, String label, IconData icon) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextFormField(
        controller: controller,
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

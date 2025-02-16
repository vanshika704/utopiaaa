
// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class VoiceButtonPage extends StatefulWidget {
//   const VoiceButtonPage({super.key});

//   @override
//   State<VoiceButtonPage> createState() => _VoiceButtonPageState();
// }

// class _VoiceButtonPageState extends State<VoiceButtonPage> {
//   stt.SpeechToText _speechToText = stt.SpeechToText();
//   bool _isListening = false;
//   double _buttonSize = 200.0;
//   Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Original color
//   String _recognizedText = "";  // Variable to store recognized text
//   double _circleSize = 240.0;  // Size of the circular animation effect
//   double _circleOpacity = 0.0;  // Opacity of the circle for animation effect
//   double _hollowCircleSize = 250.0;  // Size of the hollow circle around the button

//   @override
//   void initState() {
//     super.initState();
//     _speechToText.initialize(onStatus: (status) {
//       if (status == "listening") {
//         setState(() {
//           _isListening = true;
//           _buttonSize = 220.0;
//           _buttonColor = const Color.fromARGB(255, 92, 215, 147);  // Turn button green while listening
//           _circleSize = 280.0;  // Enlarge the circle effect when listening
//           _circleOpacity = 0.3;  // Show the circular effect when listening
//           _hollowCircleSize = 300.0;  // Enlarge the hollow circle when listening
//         });
//       } else {
//         setState(() {
//           _isListening = false;
//           _buttonSize = 200.0;
//           _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Default color when not listening
//           _circleSize = 240.0;  // Reset the circle size
//           _circleOpacity = 0.0;  // Hide the circle when not listening
//           _hollowCircleSize = 270.0;  // Reset the hollow circle size
//         });
//       }
//     });
//   }

//   // Start listening to the microphone
//   void _startListening() {
//     _speechToText.listen(onResult: (result) {
//       setState(() {
//         _recognizedText = result.recognizedWords;  // Update recognized text
//         _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Reset color after listening
//         _circleSize = 240.0;  // Reset the circle size
//         _circleOpacity = 0.0;  // Hide the circle effect after listening
//         _hollowCircleSize = 270.0;  // Reset the hollow circle size
//       });
//     });
//   }

//   // Stop listening to the microphone
//   void _stopListening() {
//     _speechToText.stop();
//     setState(() {
//       _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Reset color after stop listening
//       _circleSize = 240.0;  // Reset the circle size
//       _circleOpacity = 0.0;  // Hide the circle effect
//       _hollowCircleSize = 270.0;  // Reset the hollow circle size
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 224, 191, 172),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Hollow circle around the button
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _hollowCircleSize,
//                       height: _hollowCircleSize,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         border: Border.all(
//                           color: const Color.fromARGB(255, 80, 59, 46),  // Hollow circle color
//                           width: 6.0,  // Border thickness
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     // Circular animation effect (outside of the button)
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _circleSize,
//                       height: _circleSize,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 74, 238, 109).withOpacity(_circleOpacity),  // Color with opacity
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     // The actual button inside the animated circle
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       width: _buttonSize,
//                       height: _buttonSize,
//                       decoration: BoxDecoration(
//                         color: _buttonColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           _isListening ? Icons.mic : Icons.mic_none,
//                           color: const Color.fromARGB(255, 80, 59, 46),
//                           size: 70.0,
//                         ),
//                         onPressed: () {
//                           if (_isListening) {
//                             _stopListening();  // Stop listening if already listening
//                           } else {
//                             setState(() {
//                               _buttonColor = const Color.fromARGB(255, 96, 194, 127);  // Turn button green when pressed to start listening
//                             });
//                             _startListening();  // Start listening when button is pressed
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 // Display the recognized text when listening
//                 if (_isListening)
//                   const Text(
//                     'Listening...',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 const SizedBox(height: 20),
//                 // Display recognized words
//                 Text(
//                   _recognizedText.isEmpty ? 'Say something...' : _recognizedText,
//                   style: const TextStyle(fontSize: 24, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           // Rectangular padding at the bottom
//           Positioned(
//             bottom: 10,
//             left: screenWidth * 0.25,  // Adjust the left position to center the padding
//             child: Container(
//               width: screenWidth * 0.50,
//               height: 4,
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
// }
////////////////////////////////////////////////////////////////////////////////////////////////
// import 'package:flutter/material.dart';
// import 'package:porcupine_flutter/porcupine_manager.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_dotenv/flutter_dotenv.dart';


// class VoiceButtonPage extends StatefulWidget {
//   const VoiceButtonPage({super.key});

//   @override
//   State<VoiceButtonPage> createState() => _VoiceButtonPageState();
// }

// class _VoiceButtonPageState extends State<VoiceButtonPage> {
//   stt.SpeechToText _speechToText = stt.SpeechToText();
//   bool _isListening = false;
//   double _buttonSize = 200.0;
//   Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Original color
//   String _recognizedText = "";  // Variable to store recognized text
//   double _circleSize = 240.0;  // Size of the circular animation effect
//   double _circleOpacity = 0.0;  // Opacity of the circle for animation effect
//   double _hollowCircleSize = 250.0;  // Size of the hollow circle around the button
  
//   late PorcupineManager _porcupineManager;
//   bool _isWakeWordDetected = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializePorcupine();
//     _speechToText.initialize(onStatus: (status) {
//       if (status == "listening") {
//         setState(() {
//           _isListening = true;
//           _buttonSize = 220.0;
//           _buttonColor = const Color.fromARGB(255, 92, 215, 147);  // Turn button green while listening
//           _circleSize = 280.0;  // Enlarge the circle effect when listening
//           _circleOpacity = 0.3;  // Show the circular effect when listening
//           _hollowCircleSize = 300.0;  // Enlarge the hollow circle when listening
//         });
//       } else {
//         setState(() {
//           _isListening = false;
//           _buttonSize = 200.0;
//           _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Default color when not listening
//           _circleSize = 240.0;  // Reset the circle size
//           _circleOpacity = 0.0;  // Hide the circle when not listening
//           _hollowCircleSize = 270.0;  // Reset the hollow circle size
//         });
//       }
//     });
//   }

//   // Initialize Porcupine for wake word detection
//   Future<void> _initializePorcupine() async {
//     try {
//       String apiKey = dotenv.env['ACCESS_KEY'] ?? '';
//       if (apiKey.isEmpty) {
//         print("API Key is missing!");
//         return;
//       }
      
//       List<String> wakeWords = ['assets/ok-help_en_android_v3_0_0.ppn']; // Add your wake word model path
//       _porcupineManager = await PorcupineManager.fromKeywordPaths(
//         apiKey,
//         wakeWords,
//         (int index) {
//           setState(() {
//             _isWakeWordDetected = true; // Set to true when a wake word is detected
//           });
//           print("Wake word detected: $index");
//         },
        
//       );

//       await _porcupineManager.start();
//     } catch (e) {
//       print("Error initializing Porcupine: $e");
//     }
//   }

//   // Start listening to the microphone
//   void _startListening() {
//     _speechToText.listen(onResult: (result) {
//       setState(() {
//         _recognizedText = result.recognizedWords;  // Update recognized text
//         _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Reset color after listening
//         _circleSize = 240.0;  // Reset the circle size
//         _circleOpacity = 0.0;  // Hide the circle effect after listening
//         _hollowCircleSize = 270.0;  // Reset the hollow circle size
//       });
//     });
//   }

//   // Stop listening to the microphone
//   void _stopListening() {
//     _speechToText.stop();
//     setState(() {
//       _buttonColor = const Color.fromARGB(255, 227, 227, 227);  // Reset color after stop listening
//       _circleSize = 240.0;  // Reset the circle size
//       _circleOpacity = 0.0;  // Hide the circle effect
//       _hollowCircleSize = 270.0;  // Reset the hollow circle size
//     });
//   }

//   @override
//   void dispose() {
//     _porcupineManager.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 224, 191, 172),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     // Hollow circle around the button
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _hollowCircleSize,
//                       height: _hollowCircleSize,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         border: Border.all(
//                           color: const Color.fromARGB(255, 80, 59, 46),
//                           width: 6.0,  // Border thickness
//                         ),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     // Circular animation effect (outside of the button)
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _circleSize,
//                       height: _circleSize,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 74, 238, 109).withOpacity(_circleOpacity),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     // The actual button inside the animated circle
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       width: _buttonSize,
//                       height: _buttonSize,
//                       decoration: BoxDecoration(
//                         color: _buttonColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           _isListening ? Icons.mic : Icons.mic_none,
//                           color: const Color.fromARGB(255, 80, 59, 46),
//                           size: 70.0,
//                         ),
//                         onPressed: () {
//                           if (_isListening) {
//                             _stopListening();  // Stop listening if already listening
//                           } else {
//                             setState(() {
//                               _buttonColor = const Color.fromARGB(255, 96, 194, 127);
//                             });
//                             _startListening();  // Start listening when button is pressed
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 if (_isListening)
//                   const Text(
//                     'Listening...',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 const SizedBox(height: 20),
//                 Text(
//                   _recognizedText.isEmpty ? 'Say something...' : _recognizedText,
//                   style: const TextStyle(fontSize: 24, color: Colors.black),
//                 ),
//                 if (_isWakeWordDetected)
//                   const Text(
//                     'Wake word detected!',
//                     style: TextStyle(fontSize: 20, color: Colors.green),
//                   ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: screenWidth * 0.25,
//             child: Container(
//               width: screenWidth * 0.50,
//               height: 4,
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
// }
/////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/material.dart';
import 'package:porcupine_flutter/porcupine_manager.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VoiceButtonPage extends StatefulWidget {
  const VoiceButtonPage({super.key});

  @override
  State<VoiceButtonPage> createState() => _VoiceButtonPageState();
}

class _VoiceButtonPageState extends State<VoiceButtonPage> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  double _buttonSize = 200.0;
  Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);
  String _recognizedText = "";
  double _circleSize = 240.0;
  double _circleOpacity = 0.0;
  double _hollowCircleSize = 250.0;
  late PorcupineManager _porcupineManager;
  bool _isWakeWordDetected = false;
  String? userUniqueCode;

  @override
  void initState() {
    super.initState();
    _initializePorcupine();
    _initializeSpeechToText();
  }

  Future<void> _initializePorcupine() async {
    try {
      String apiKey = dotenv.env['ACCESS_KEY'] ?? '';
      if (apiKey.isEmpty) {
        print("API Key is missing!");
        return;
      }
      List<String> wakeWords = ['assets/ok-help_en_android_v3_0_0.ppn'];
      _porcupineManager = await PorcupineManager.fromKeywordPaths(
        apiKey,
        wakeWords,
        (int index) {
          setState(() {
            _isWakeWordDetected = true;
          });
          print("Wake word detected");
          _startListening();
        },
      );
      await _porcupineManager.start();
    } catch (e) {
      print("Error initializing Porcupine: $e");
    }
  }

  void _initializeSpeechToText() {
    _speechToText.initialize(onStatus: (status) {
      if (status == "listening") {
        setState(() {
          _isListening = true;
          _buttonSize = 220.0;
          _buttonColor = const Color.fromARGB(255, 97, 203, 139);
          _circleSize = 280.0;
          _circleOpacity = 0.3;
          _hollowCircleSize = 300.0;
        });
      } else {
        setState(() {
          _isListening = false;
          _buttonSize = 200.0;
          _buttonColor = const Color.fromARGB(255, 227, 227, 227);
          _circleSize = 240.0;
          _circleOpacity = 0.0;
          _hollowCircleSize = 270.0;
        });
      }
    });
  }

  void _startListening() {
    _speechToText.listen(onResult: (result) {
      setState(() {
        _recognizedText = result.recognizedWords.trim().toUpperCase();
      });
      if (userUniqueCode != null && _recognizedText.contains(userUniqueCode!.toUpperCase())) {
        _triggerEmergencyAction();
      }
    });
  }

  Future<void> _triggerEmergencyAction() async {
    const APIURI= 'https://utopiaa-rqkd.onrender.com/api/users/trigger-emergency';
    if (userUniqueCode == null) return;
    final response = await http.post(
      Uri.parse(APIURI),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"uniqueCode": userUniqueCode}),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Emergency alert sent!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send alert.")),
      );
    }
  }

  @override
  void dispose() {
    _porcupineManager.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 191, 172),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: _hollowCircleSize,
                      height: _hollowCircleSize,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: const Color.fromARGB(255, 76, 53, 45), width: 6.0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: _circleSize,
                      height: _circleSize,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 81, 190, 127).withOpacity(_circleOpacity),
                        shape: BoxShape.circle,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: _buttonSize,
                      height: _buttonSize,
                      decoration: BoxDecoration(
                        color: _buttonColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _isListening ? Icons.mic : Icons.mic_none,
                          color: const Color.fromARGB(255, 72, 46, 37),
                          size: 70.0,
                        ),
                        onPressed: () {
                          if (_isListening) {
                            _speechToText.stop();
                          } else {
                            _startListening();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(_recognizedText.isEmpty ? 'Say something...' : _recognizedText,
                    style: const TextStyle(fontSize: 24, color: Colors.black)),
                if (_isWakeWordDetected)
                  const Text('Wake word detected!', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 41, 87, 42))),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: screenWidth * 0.25,
            child: Container(
              width: screenWidth * 0.50,
              height: 4,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 36, 26, 26),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
///////////////
// import 'package:flutter/material.dart';
// import 'package:porcupine_flutter/porcupine_manager.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class VoiceButtonPage extends StatefulWidget {
//   const VoiceButtonPage({super.key});

//   @override
//   State<VoiceButtonPage> createState() => _VoiceButtonPageState();
// }

// class _VoiceButtonPageState extends State<VoiceButtonPage> {
//   stt.SpeechToText _speechToText = stt.SpeechToText();
//   bool _isListening = false;
//   double _buttonSize = 200.0;
//   Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);
//   String _recognizedText = "";
//   double _circleSize = 240.0;
//   double _circleOpacity = 0.0;
//   double _hollowCircleSize = 250.0;
//   late PorcupineManager _porcupineManager;
//   bool _isWakeWordDetected = false;
//   String? userUniqueCode;

//   @override
//   void initState() {
//     super.initState();
//     _initializePorcupine();
//     _initializeSpeechToText();
//   }

//   Future<void> _initializePorcupine() async {
//     try {
//       String apiKey = dotenv.env['ACCESS_KEY'] ?? '';
//       if (apiKey.isEmpty) {
//         print("API Key is missing!");
//         return;
//       }
//       List<String> wakeWords = ['assets/ok-help_en_android_v3_0_0.ppn'];
//       _porcupineManager = await PorcupineManager.fromKeywordPaths(
//         apiKey,
//         wakeWords,
//         (int index) {
//           setState(() {
//             _isWakeWordDetected = true;
//           });
//           print("Wake word detected");
//           _startListening();
//         },
//       );
//       await _porcupineManager.start();
//     } catch (e) {
//       print("Error initializing Porcupine: $e");
//     }
//   }

//   void _initializeSpeechToText() {
//     _speechToText.initialize(onStatus: (status) {
//       if (status == "listening") {
//         setState(() {
//           _isListening = true;
//           _buttonSize = 220.0;
//           _buttonColor = const Color.fromARGB(255, 97, 203, 139);
//           _circleSize = 280.0;
//           _circleOpacity = 0.3;
//           _hollowCircleSize = 300.0;
//         });
//       } else {
//         setState(() {
//           _isListening = false;
//           _buttonSize = 200.0;
//           _buttonColor = const Color.fromARGB(255, 227, 227, 227);
//           _circleSize = 240.0;
//           _circleOpacity = 0.0;
//           _hollowCircleSize = 270.0;
//         });
//       }
//     });
//   }

//   void _startListening() {
//     if (!_speechToText.isAvailable || _speechToText.isListening) return;

//     _speechToText.listen(
//       onResult: (result) {
//         setState(() {
//           _recognizedText = result.recognizedWords.trim().toUpperCase();
//         });

//         if (userUniqueCode != null && _recognizedText.contains(userUniqueCode!.toUpperCase())) {
//           _triggerEmergencyAction();
//           _speechToText.stop(); // Stop only if unique code is detected
//         }
//       },
//       listenFor: const Duration(seconds: 5), // Extend listening duration
//       pauseFor: const Duration(seconds: 2),  // Pause before stopping
//       onSoundLevelChange: (level) {},
//       cancelOnError: false, // Prevents unexpected stops
//       listenMode: stt.ListenMode.dictation, // Continuous listening mode
//     );

//     // Restart listening if it stops before detecting the unique code
//     Future.delayed(const Duration(seconds: 6), () {
//       if (!_speechToText.isListening) {
//         _startListening();
//       }
//     });
//   }

//   Future<void> _triggerEmergencyAction() async {
//     const APIURI = 'https://utopiaa-rqkd.onrender.com/api/users/trigger-emergency';
//     if (userUniqueCode == null) return;

//     final response = await http.post(
//       Uri.parse(APIURI),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({"uniqueCode": userUniqueCode}),
//     );

//     if (response.statusCode == 200) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("🚨 Emergency alert sent!")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("⚠️ Failed to send alert.")),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _porcupineManager.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 224, 191, 172),
//       body: Stack(
//         children: [
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   alignment: Alignment.center,
//                   children: [
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _hollowCircleSize,
//                       height: _hollowCircleSize,
//                       decoration: BoxDecoration(
//                         color: Colors.transparent,
//                         border: Border.all(color: const Color.fromARGB(255, 76, 53, 45), width: 6.0),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _circleSize,
//                       height: _circleSize,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 81, 190, 127).withOpacity(_circleOpacity),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 300),
//                       curve: Curves.easeInOut,
//                       width: _buttonSize,
//                       height: _buttonSize,
//                       decoration: BoxDecoration(
//                         color: _buttonColor,
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         icon: Icon(
//                           _isListening ? Icons.mic : Icons.mic_none,
//                           color: const Color.fromARGB(255, 72, 46, 37),
//                           size: 70.0,
//                         ),
//                         onPressed: () {
//                           if (_isListening) {
//                             _speechToText.stop();
//                           } else {
//                             _startListening();
//                           }
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Text(_recognizedText.isEmpty ? 'Say something...' : _recognizedText,
//                     style: const TextStyle(fontSize: 24, color: Colors.black)),
//                 if (_isWakeWordDetected)
//                   const Text('Wake word detected!', style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 41, 87, 42))),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             left: screenWidth * 0.25,
//             child: Container(
//               width: screenWidth * 0.50,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

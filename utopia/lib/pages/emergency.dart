// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:url_launcher/url_launcher.dart';


// class VoiceButtonPage extends StatefulWidget {
//   const VoiceButtonPage({super.key});

//   @override
//   State<VoiceButtonPage> createState() => _VoiceButtonPageState();
// }

// class _VoiceButtonPageState extends State<VoiceButtonPage> {
//   late stt.SpeechToText _speechToText;
//   bool _isListening = false;
//   double _buttonSize = 200.0;
//   Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);
//   String _recognizedText = "";
//   double _circleSize = 240.0;
//   double _circleOpacity = 0.0;
//   double _hollowCircleSize = 250.0;

//   final List<String> emergencyContacts = [
//     "9996950221" // Add your emergency contacts here
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _speechToText = stt.SpeechToText();
//     _initializeSpeechToText();
//     _askPermissions();
//   }

//   Future<void> _askPermissions() async {
//     await [Permission.microphone, Permission.location, Permission.sms].request();
//   }

//   void _initializeSpeechToText() async {
//     bool available = await _speechToText.initialize(
//       onStatus: (status) {
//         setState(() {
//           _isListening = status == "listening";
//           _buttonSize = _isListening ? 220.0 : 200.0;
//           _buttonColor = _isListening
//               ? const Color.fromARGB(255, 97, 203, 139)
//               : const Color.fromARGB(255, 227, 227, 227);
//           _circleSize = _isListening ? 280.0 : 240.0;
//           _circleOpacity = _isListening ? 0.3 : 0.0;
//           _hollowCircleSize = _isListening ? 300.0 : 270.0;
//         });
//       },
//     );
    
//     if (!available) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Speech recognition not available')),
//         );
//       }
//     }
//   }

//   void _startListening() async {
//     bool available = await _speechToText.initialize();
//     if (!available) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Speech recognition not available')),
//         );
//       }
//       return;
//     }

//     _speechToText.listen(
//       onResult: (result) {
//         setState(() {
//           _recognizedText = result.recognizedWords.trim().toLowerCase();
//         });
//         if (_recognizedText.contains("ok help")) {
//           _triggerEmergencyProtocol();
//         }
//       },
//       listenFor: const Duration(seconds: 30),
//       pauseFor: const Duration(seconds: 5),
//     );
//   }

//   Future<void> _triggerEmergencyProtocol() async {
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Please enable location services')),
//           );
//         }
//         return;
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Location permissions are denied')),
//             );
//           }
//           return;
//         }
//       }

//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);

//       String message =
//           "🚨 Emergency! I need help. My location: https://maps.google.com/?q=${position.latitude},${position.longitude}";

//       for (String contact in emergencyContacts) {
//         final Uri smsUri = Uri(
//           scheme: 'sms',
//           path: contact,
//           queryParameters: {'body': message},
//         );
//         if (await canLaunchUrl(smsUri)) {
//           await launchUrl(smsUri);
//         } else {
//           if (mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Could not launch SMS app')),
//             );
//           }
//         }
//       }

//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Emergency SMS sent!')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${e.toString()}')),
//         );
//       }
//     }
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
//                         border: Border.all(
//                             color: const Color.fromARGB(255, 76, 53, 45),
//                             width: 6.0),
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     AnimatedContainer(
//                       duration: const Duration(milliseconds: 500),
//                       width: _circleSize,
//                       height: _circleSize,
//                       decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 81, 190, 127)
//                             .withOpacity(_circleOpacity),
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
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: Text(
//                     _recognizedText.isEmpty
//                         ? 'Say "OK Help" to trigger emergency'
//                         : _recognizedText,
//                     style: const TextStyle(fontSize: 24, color: Colors.black),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             left: screenWidth * 0.25,
//             child: Container(
//               width: screenWidth * 0.50,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 36, 26, 26),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class VoiceButtonPage extends StatefulWidget {
  const VoiceButtonPage({super.key});

  @override
  State<VoiceButtonPage> createState() => _VoiceButtonPageState();
}

class _VoiceButtonPageState extends State<VoiceButtonPage> {
  late stt.SpeechToText _speechToText;
  bool _isListening = false;
  double _buttonSize = 200.0;
  Color _buttonColor = const Color.fromARGB(255, 227, 227, 227);
  String _recognizedText = "";
  double _circleSize = 240.0;
  double _circleOpacity = 0.0;
  double _hollowCircleSize = 250.0;
  bool _isSendingSMS = false;

  final List<String> emergencyContacts = ["9996950221"];

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
    _initializeSpeechToText();
    _askPermissions();
  }

  Future<void> _askPermissions() async {
    await [Permission.microphone, Permission.location, Permission.sms].request();
  }

  void _initializeSpeechToText() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) {
        setState(() {
          _isListening = status == "listening";
          _updateButtonState();
        });
      },
    );
    
    if (!available && mounted) {
      _showSnackBar('Speech recognition not available');
    }
  }

  void _updateButtonState() {
    setState(() {
      _buttonSize = _isListening ? 220.0 : 200.0;
      _buttonColor = _isListening
          ? const Color.fromARGB(255, 97, 203, 139)
          : const Color.fromARGB(255, 227, 227, 227);
      _circleSize = _isListening ? 280.0 : 240.0;
      _circleOpacity = _isListening ? 0.3 : 0.0;
      _hollowCircleSize = _isListening ? 300.0 : 270.0;
    });
  }

  void _startListening() async {
    if (_isSendingSMS) return;
    
    bool available = await _speechToText.initialize();
    if (!available) {
      if (mounted) {
        _showSnackBar('Speech recognition not available');
      }
      return;
    }

    _speechToText.listen(
      onResult: (result) async {
        setState(() => _recognizedText = result.recognizedWords.trim().toLowerCase());
        
        if (_recognizedText.contains("okay help") && !_isSendingSMS) {
          await _triggerEmergencyProtocol();
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
    );
  }

  Future<void> _triggerEmergencyProtocol() async {
    if (_isSendingSMS) return;
    
    setState(() => _isSendingSMS = true);
    
    try {
      // 1. Show starting message
      _showSnackBar('Starting emergency protocol...');
      
      // 2. Check location services
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showSnackBar('Please enable location services');
        return;
      }

      // 3. Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showSnackBar('Location permissions are denied');
          return;
        }
      }

      // 4. Get current position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      String message =
          "🚨 Emergency! I need help. My location: https://maps.google.com/?q=${position.latitude},${position.longitude}";

      // 5. Send SMS to all contacts
      bool atLeastOneSent = false;
      for (String contact in emergencyContacts) {
        final Uri smsUri = Uri(
          scheme: 'sms',
          path: contact,
          queryParameters: {'body': message},
        );
        
        if (await canLaunchUrl(smsUri)) {
          await launchUrl(smsUri);
          atLeastOneSent = true;
        }
      }

      // 6. Show final result
      if (atLeastOneSent) {
        _showSnackBar('Emergency SMS sent successfully!');
      } else {
        _showSnackBar('Failed to send SMS to all contacts');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    } finally {
      setState(() => _isSendingSMS = false);
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
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
                        border: Border.all(
                            color: const Color.fromARGB(255, 76, 53, 45),
                            width: 6.0),
                        shape: BoxShape.circle,
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: _circleSize,
                      height: _circleSize,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 81, 190, 127)
                            .withOpacity(_circleOpacity),
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
                        onPressed: _isSendingSMS
                            ? null
                            : () {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        _recognizedText.isEmpty
                            ? 'Say "OK Help" to trigger emergency'
                            : _recognizedText,
                        style: const TextStyle(fontSize: 24, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      if (_isSendingSMS)
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
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
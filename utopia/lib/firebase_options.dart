// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA6yDbxE0cp3GJUc2kl1qUUlwFyWYgTs2Q',
    appId: '1:741678405003:web:0ae3ce8e6be5d1a04c0b8e',
    messagingSenderId: '741678405003',
    projectId: 'utopia-9e865',
    authDomain: 'utopia-9e865.firebaseapp.com',
    storageBucket: 'utopia-9e865.firebasestorage.app',
    measurementId: 'G-D03ELX44JH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATbNSxgI1VwYh1TaZZKGbT1oyl4U4Nw4U',
    appId: '1:741678405003:android:8955bd5b84dd7a2f4c0b8e',
    messagingSenderId: '741678405003',
    projectId: 'utopia-9e865',
    storageBucket: 'utopia-9e865.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBrwsa8oQp-JW2YY6IOJtPOXBDp_V-9rFg',
    appId: '1:741678405003:ios:def9db00a7a89b554c0b8e',
    messagingSenderId: '741678405003',
    projectId: 'utopia-9e865',
    storageBucket: 'utopia-9e865.firebasestorage.app',
    iosBundleId: 'com.example.utopia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBrwsa8oQp-JW2YY6IOJtPOXBDp_V-9rFg',
    appId: '1:741678405003:ios:def9db00a7a89b554c0b8e',
    messagingSenderId: '741678405003',
    projectId: 'utopia-9e865',
    storageBucket: 'utopia-9e865.firebasestorage.app',
    iosBundleId: 'com.example.utopia',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA6yDbxE0cp3GJUc2kl1qUUlwFyWYgTs2Q',
    appId: '1:741678405003:web:4434392a72c3a93f4c0b8e',
    messagingSenderId: '741678405003',
    projectId: 'utopia-9e865',
    authDomain: 'utopia-9e865.firebaseapp.com',
    storageBucket: 'utopia-9e865.firebasestorage.app',
    measurementId: 'G-64JB2LL7JX',
  );
}

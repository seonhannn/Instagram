// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBKb3g_nqAuwzIzpmSjzuzVy30B-X62RTc',
    appId: '1:67150396102:web:a411a04560275cbe7935c7',
    messagingSenderId: '67150396102',
    projectId: 'fluttergram-66e26',
    authDomain: 'fluttergram-66e26.firebaseapp.com',
    storageBucket: 'fluttergram-66e26.appspot.com',
    measurementId: 'G-L29HX6BFHS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmxrX_6NHApAmjgORiuYhvnXwLJ8API5E',
    appId: '1:67150396102:android:c1d5e7a6fa0b94507935c7',
    messagingSenderId: '67150396102',
    projectId: 'fluttergram-66e26',
    storageBucket: 'fluttergram-66e26.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFG8dcZkH9zrrPnu1me5t8vg2bPlL3vyA',
    appId: '1:67150396102:ios:715265b5862bdb357935c7',
    messagingSenderId: '67150396102',
    projectId: 'fluttergram-66e26',
    storageBucket: 'fluttergram-66e26.appspot.com',
    iosClientId: '67150396102-9p4rrnigdrp74cruo66nvslr84nmu2su.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagram',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFG8dcZkH9zrrPnu1me5t8vg2bPlL3vyA',
    appId: '1:67150396102:ios:715265b5862bdb357935c7',
    messagingSenderId: '67150396102',
    projectId: 'fluttergram-66e26',
    storageBucket: 'fluttergram-66e26.appspot.com',
    iosClientId: '67150396102-9p4rrnigdrp74cruo66nvslr84nmu2su.apps.googleusercontent.com',
    iosBundleId: 'com.example.instagram',
  );
}

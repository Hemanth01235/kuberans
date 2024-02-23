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
    apiKey: 'AIzaSyDEUkrxfW8EPDa9DuJBXCvG3WExBo2_wPY',
    appId: '1:70342206073:web:28d3684c6d223febdc2aa8',
    messagingSenderId: '70342206073',
    projectId: 'kuberans-943ee',
    authDomain: 'kuberans-943ee.firebaseapp.com',
    storageBucket: 'kuberans-943ee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAqnH2CUVzNU5b86Euc7LvmPl3ZCsuQlQ',
    appId: '1:70342206073:android:df4578e6da46a381dc2aa8',
    messagingSenderId: '70342206073',
    projectId: 'kuberans-943ee',
    storageBucket: 'kuberans-943ee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-ZvzsBNL-4l8B_qZFTaBEiS3J9xhc5gY',
    appId: '1:70342206073:ios:248e81e826d1e0b8dc2aa8',
    messagingSenderId: '70342206073',
    projectId: 'kuberans-943ee',
    storageBucket: 'kuberans-943ee.appspot.com',
    iosClientId: '70342206073-j21jdjqg21cqonp6q4v0q2jvolfa9fvv.apps.googleusercontent.com',
    iosBundleId: 'com.example.kuberans',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-ZvzsBNL-4l8B_qZFTaBEiS3J9xhc5gY',
    appId: '1:70342206073:ios:a2b2d40a1717adc3dc2aa8',
    messagingSenderId: '70342206073',
    projectId: 'kuberans-943ee',
    storageBucket: 'kuberans-943ee.appspot.com',
    iosClientId: '70342206073-7qg45s12o4k3ko8u0tjsn4gt62agvr4h.apps.googleusercontent.com',
    iosBundleId: 'com.example.kuberans.RunnerTests',
  );
}

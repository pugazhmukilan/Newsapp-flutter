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
    apiKey: 'AIzaSyBTS2bpgZEpHkzCM1PYOpBrRUwJApq4W_0',
    appId: '1:1012620034683:web:77e018c0bca862d39c58de',
    messagingSenderId: '1012620034683',
    projectId: 'news-app-ba88b',
    authDomain: 'news-app-ba88b.firebaseapp.com',
    storageBucket: 'news-app-ba88b.appspot.com',
    measurementId: 'G-VCXLWGJZBN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClXJhoKLF0RNhkb9DpHoPNByGbYW16CzU',
    appId: '1:1012620034683:android:952b3f79232ca4669c58de',
    messagingSenderId: '1012620034683',
    projectId: 'news-app-ba88b',
    storageBucket: 'news-app-ba88b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdJwGljB2Lu2cvI6aZrt_MppXk0Zi_aHA',
    appId: '1:1012620034683:ios:0440831ea08625699c58de',
    messagingSenderId: '1012620034683',
    projectId: 'news-app-ba88b',
    storageBucket: 'news-app-ba88b.appspot.com',
    iosClientId: '1012620034683-fivlarjqekv7o8lu71nca3tl67q9poip.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdJwGljB2Lu2cvI6aZrt_MppXk0Zi_aHA',
    appId: '1:1012620034683:ios:56a3a3282e14362f9c58de',
    messagingSenderId: '1012620034683',
    projectId: 'news-app-ba88b',
    storageBucket: 'news-app-ba88b.appspot.com',
    iosClientId: '1012620034683-n4t39ilmi65jjon0n5sl5p5lnpr2sg13.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsApp.RunnerTests',
  );
}
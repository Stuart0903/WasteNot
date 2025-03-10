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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAdmF9OV1saDd8jfI9jLtSptDUJJLx9g-k',
    appId: '1:736737811654:android:b1eeeb8873341f5131cbc7',
    messagingSenderId: '736737811654',
    projectId: 'wastenott-2a064',
    storageBucket: 'wastenott-2a064.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCy94cUbohiFh7HNsm6Q8r4JkeuICtNdWA',
    appId: '1:736737811654:ios:5f9107f8251ec9d131cbc7',
    messagingSenderId: '736737811654',
    projectId: 'wastenott-2a064',
    storageBucket: 'wastenott-2a064.firebasestorage.app',
    androidClientId: '762361306872-cbd1orbk0pkg02d8peo06te0tupmak1a.apps.googleusercontent.com',
    iosClientId: '762361306872-gfvmuo22qrm2cn6m8co4ed8mert5k467.apps.googleusercontent.com',
    iosBundleId: 'com.example.wastenot',
  );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDfOpouat_9PJ94b0oWmTGWh92-gB4V5G8",
      authDomain: "wastenott-2a064.firebaseapp.com",
      projectId: "wastenott-2a064",
      storageBucket: "wastenott-2a064.firebasestorage.app",
      messagingSenderId: "736737811654",
      appId: "1:736737811654:web:66d8df278104938631cbc7"
  );

}
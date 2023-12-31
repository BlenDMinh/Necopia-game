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
    apiKey: 'AIzaSyBER0eKUT6P8ltSVxTuwQAwehRWxheQnSg',
    appId: '1:398104767404:web:5e75eebd794a2aa80ea809',
    messagingSenderId: '398104767404',
    projectId: 'necopia-ebe33',
    authDomain: 'necopia-ebe33.firebaseapp.com',
    storageBucket: 'necopia-ebe33.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCe4kpMaQd1GdnUWsRQ-Be0Kjx5iuSKfcs',
    appId: '1:398104767404:android:219c7f639b9014c90ea809',
    messagingSenderId: '398104767404',
    projectId: 'necopia-ebe33',
    storageBucket: 'necopia-ebe33.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTZ4CmW6LjIxQtbm3OzbeQT349vq35hfM',
    appId: '1:398104767404:ios:5fac694d0e2013fc0ea809',
    messagingSenderId: '398104767404',
    projectId: 'necopia-ebe33',
    storageBucket: 'necopia-ebe33.appspot.com',
    iosClientId:
        '398104767404-shtj7nrlc3e4q5u2a4j55pflbauel4po.apps.googleusercontent.com',
    iosBundleId: 'com.example.necopia',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTZ4CmW6LjIxQtbm3OzbeQT349vq35hfM',
    appId: '1:398104767404:ios:5fac694d0e2013fc0ea809',
    messagingSenderId: '398104767404',
    projectId: 'necopia-ebe33',
    storageBucket: 'necopia-ebe33.appspot.com',
    iosClientId:
        '398104767404-shtj7nrlc3e4q5u2a4j55pflbauel4po.apps.googleusercontent.com',
    iosBundleId: 'com.example.necopia',
  );
}

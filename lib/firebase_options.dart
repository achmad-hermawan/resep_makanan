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
    apiKey: 'AIzaSyAR5VEGPKqhs3wnRQFkb-96kJF7xUicmQ0',
    appId: '1:237493145500:web:8d9a9402414abf39630259',
    messagingSenderId: '237493145500',
    projectId: 'resep-makanan-app-85d16',
    authDomain: 'resep-makanan-app-85d16.firebaseapp.com',
    storageBucket: 'resep-makanan-app-85d16.firebasestorage.app',
    measurementId: 'G-QW45W152R1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBgEpjFH4Fv-SCr6IQcenx3zVLH_MQHblY',
    appId: '1:237493145500:android:91a74814946a0029630259',
    messagingSenderId: '237493145500',
    projectId: 'resep-makanan-app-85d16',
    storageBucket: 'resep-makanan-app-85d16.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC3wTBphEo1Y6Tyi_8UkGecHBvIIKSLxHs',
    appId: '1:237493145500:ios:f2c7bdd586790183630259',
    messagingSenderId: '237493145500',
    projectId: 'resep-makanan-app-85d16',
    storageBucket: 'resep-makanan-app-85d16.firebasestorage.app',
    iosBundleId: 'com.hermawan.resepMakanan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC3wTBphEo1Y6Tyi_8UkGecHBvIIKSLxHs',
    appId: '1:237493145500:ios:f2c7bdd586790183630259',
    messagingSenderId: '237493145500',
    projectId: 'resep-makanan-app-85d16',
    storageBucket: 'resep-makanan-app-85d16.firebasestorage.app',
    iosBundleId: 'com.hermawan.resepMakanan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAR5VEGPKqhs3wnRQFkb-96kJF7xUicmQ0',
    appId: '1:237493145500:web:ea1bdb5a3a37b119630259',
    messagingSenderId: '237493145500',
    projectId: 'resep-makanan-app-85d16',
    authDomain: 'resep-makanan-app-85d16.firebaseapp.com',
    storageBucket: 'resep-makanan-app-85d16.firebasestorage.app',
    measurementId: 'G-T5JW2Q6FBL',
  );
}

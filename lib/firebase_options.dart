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
    apiKey: 'AIzaSyAcfPrnfl0urJpi6aINxsxLCH2Txp-msrc',
    appId: '1:484751014681:web:5699a2724345a1ac0ca388',
    messagingSenderId: '484751014681',
    projectId: 'orbitalflutterhawkerbro',
    authDomain: 'orbitalflutterhawkerbro.firebaseapp.com',
    databaseURL: 'https://orbitalflutterhawkerbro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orbitalflutterhawkerbro.appspot.com',
    measurementId: 'G-LQWEH52ZD9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCx3KbABiG19bpfUtvEQqZJBFNSdDrvoD0',
    appId: '1:484751014681:android:9fdd74d542b9ef3d0ca388',
    messagingSenderId: '484751014681',
    projectId: 'orbitalflutterhawkerbro',
    databaseURL: 'https://orbitalflutterhawkerbro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orbitalflutterhawkerbro.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDxVOet3ECtpkVK46VIg1BWP-nXhqerTiw',
    appId: '1:484751014681:ios:f998b423edab73e70ca388',
    messagingSenderId: '484751014681',
    projectId: 'orbitalflutterhawkerbro',
    databaseURL: 'https://orbitalflutterhawkerbro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orbitalflutterhawkerbro.appspot.com',
    androidClientId: '484751014681-8arepdght5fvgikq950h0gs6daid77fu.apps.googleusercontent.com',
    iosClientId: '484751014681-77815ql63m9vb35qj5o0eu29bsfbha3e.apps.googleusercontent.com',
    iosBundleId: 'com.example.hawkerbro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDxVOet3ECtpkVK46VIg1BWP-nXhqerTiw',
    appId: '1:484751014681:ios:d5c22844d5bd64f90ca388',
    messagingSenderId: '484751014681',
    projectId: 'orbitalflutterhawkerbro',
    databaseURL: 'https://orbitalflutterhawkerbro-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'orbitalflutterhawkerbro.appspot.com',
    androidClientId: '484751014681-8arepdght5fvgikq950h0gs6daid77fu.apps.googleusercontent.com',
    iosClientId: '484751014681-dm7m49iv6ih12effj86aq4jpapk2h885.apps.googleusercontent.com',
    iosBundleId: 'com.example.hawkerbro.RunnerTests',
  );
}

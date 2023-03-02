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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyAsrPL-ppiKBGa2F3KtnyWQUt3yeIuGJqw',
    appId: '1:751099778691:android:4d13f5dd0c5a09a05c2db6',
    messagingSenderId: '751099778691',
    projectId: 'qrcode-getx-65b56',
    storageBucket: 'qrcode-getx-65b56.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAWHSF4VLoc6xllc6tKOqkMIeNB-BGOvA',
    appId: '1:751099778691:ios:e97b8ddb53d715f35c2db6',
    messagingSenderId: '751099778691',
    projectId: 'qrcode-getx-65b56',
    storageBucket: 'qrcode-getx-65b56.appspot.com',
    iosClientId: '751099778691-g6f2ni2d1ipoh4e5knt3hjvrrg09gc9h.apps.googleusercontent.com',
    iosBundleId: 'com.nfl56.flutterQrcodeGetxProject',
  );
}

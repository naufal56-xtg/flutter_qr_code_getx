import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_qrcode_getx_project/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  String? uid;

  late FirebaseAuth firebaseAuth;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return {
        'error': false,
        'message': 'Successfully Login',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': true,
        'message': '${e.message}',
      };
    } catch (err) {
      return {
        'error': true,
        'message': 'Login Failed Please Try Again',
      };
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      await firebaseAuth.signOut();

      return {
        'error': false,
        'message': 'Successfully Logout',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'error': true,
        'message': '${e.message}',
      };
    } catch (err) {
      return {
        'error': true,
        'message': 'Logout Failed Please Try Again',
      };
    }
  }

  @override
  void onInit() {
    firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}

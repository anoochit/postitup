import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  // is auth
  bool isAuth() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  // get current user
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}

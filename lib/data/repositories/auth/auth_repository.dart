import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepository extends GetxController {
  static AuthRepository get instance => Get.find<AuthRepository>();

  // Firebase auth instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get authenticated user
  User? get currentUser => _auth.currentUser;

  // Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  @override
  void onReady() {
    // Set Firebase auth persistence to local storage to save user session
    // even if the web app is closed
    _auth.setPersistence(Persistence.LOCAL);
    super.onReady();
  }

  // Login

  // Register

  // Register user by Admin

  // Email verification

  // Forgot password

  // Re authenticate user

  // Logout user

  // Delete user
}

import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:ecommerce_admin_panel/utils/constants/appwrite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app.dart';
import 'data/repositories/auth/auth_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Locale Storage
  await GetStorage.init();

  // Remove # sign from URL
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((_) => Get.put(AuthRepository()));

  // Initialize Appwrite
  Appwrite.init();

  // Main App starts here...
  runApp(const App());
}

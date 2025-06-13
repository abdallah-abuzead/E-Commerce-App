import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';

import 'my_app.dart';

void main() {
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Locale Storage

  // Remove # sign from URL
  setPathUrlStrategy();

  // Main App starts here...
  runApp(const MyApp());
}

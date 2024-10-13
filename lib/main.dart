import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pixabay_image_setu/common/my_app.dart';

Future<void> main() async {
  // Ensure that the widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Check if the file exists
  final envFile = File('.env');
  if (await envFile.exists()) {
    debugPrint("Found .env file!");
  } else {
    debugPrint("No .env file found!");
  }

  // Load the .env file before the app starts
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

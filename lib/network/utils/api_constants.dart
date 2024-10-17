import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseApiUrl {
    return "https://pixabay.com/api"; // Base API URL
    // return "${dotenv.env['API_URL']}"; // Base API URL
  }

  static String get apiKey {
    return "46461470-5f9c175239b604ae62e7bf788"; // API Key
  }
}

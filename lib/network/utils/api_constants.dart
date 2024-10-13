import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get baseApiUrl {
    return "${dotenv.env['API_URL']}"; // Base API URL
  }

  static String get apiKey {
    return "${dotenv.env['API_KEY']}"; // API Key
  }
}

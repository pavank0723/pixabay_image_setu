import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilMethods {
  static showToast(String msg, ToastType type) {
    var bgColor = Colors.grey;
    var txtColor = Colors.black;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        txtColor = Colors.white;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        txtColor = Colors.white;
        break;
      case ToastType.warning:
        bgColor = Colors.orange;
        txtColor = Colors.white;
        break;
      case ToastType.info:
        bgColor = Colors.grey;
        txtColor = Colors.black;
        break;
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 16.0);
  }

  static int generateRandomNo(int noOfDigits) {
    var rng = Random();
    var code = rng.nextInt(9 * pow(10, noOfDigits - 1).toInt()) +
        pow(10, noOfDigits).toInt();

    return code;
  }


  static String getCombinedFirstLetters(String text) {
    List<String> words = text.split(" "); // Split into individual words
    List<String> firstLetters = words.take(2).map((word) {
      if (word.isNotEmpty) {
        return word.substring(0, 1); // Extract first letter of each word
      } else {
        return ''; // Empty string for empty words
      }
    }).toList();
    return firstLetters.join(); // Join the first letters together
  }


  static String formatDateTimeToDate(String dateTimeString) {
    DateFormat inputFormat = DateFormat('M/d/yyyy h:mm:ss a');
    DateTime dateTime = inputFormat.parse(dateTimeString);
    DateFormat outputFormat = DateFormat('MM/dd/yyyy');
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  static String formatAddedOnDateToDateWithoutTime(String dateTimeString) {
    // ISO 8601 format
    DateFormat inputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime dateTime = inputFormat.parse(dateTimeString);

    // Desired output format
    DateFormat outputFormat = DateFormat('MM/dd/yyyy');
    String formattedDate = outputFormat.format(dateTime);

    return formattedDate;
  }

  int calculateDaysByDate(String startDateStr, String endDateStr) {
    // DateFormat to parse the date strings
    // DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    // Parsing the date strings to DateTime objects
    DateTime startDate = dateFormat.parse(startDateStr);
    DateTime endDate = dateFormat.parse(endDateStr);

    // Calculating the difference in days
    int differenceInDays = endDate.difference(startDate).inDays;

    return differenceInDays;
  }

  String getTimeDifference(String dateString) {
    // Parse the date string
    DateTime date = DateTime.parse(dateString);
    final Duration difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      final int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  static String breakTextIntoTwoLines(String input, int type) {
    if (type == 1) {
      List<String> words = input.split(' ');

      if (words.length == 2) {
        // If there are two words, join them with a line break
        return '${words[0]}\n${words[1]}';
      } else {
        // If there are less or more than two words, return the original string
        return input;
      }
    } else if (type == 2) {
      // Check if the input contains a dash
      if (input.contains('-')) {
        // Split the string at the dash
        List<String> parts = input.split('-');

        // Trim whitespace from the parts and format them with line breaks
        String part1 = parts[0].trim();
        String part2 = parts[1].trim();

        // Return the formatted string with the dash on a new line
        return '$part1\n - \n$part2';
      } else {
        // If no dash is found, return the original string
        return input;
      }
    } else if (type == 3) {
      // Check for special characters like '&'
      if (input.contains('&')) {
        List<String> parts = input.split('&');

        // Trim whitespace from the parts and format them with line breaks
        String part1 = parts[0].trim();
        String part2 = parts[1].trim();

        return '$part1 &\n$part2';
      } else {
        // If no special character is found, split the input string into words
        List<String> words = input.split(' ');

        // If the input has exactly two words, split into two lines
        if (words.length == 2) {
          return '${words[0]}\n${words[1]}';
        }

        // If none of the above, return the original string
        return input;
      }
    } else {
      // If an invalid type is provided, return the original string
      return input;
    }
  }
}

extension ExtMethos on State {
  showToast(String msg, ToastType type) {
    var bgColor = Colors.white12;
    var txtColor = Colors.black;

    switch (type) {
      case ToastType.success:
        bgColor = Colors.green;
        txtColor = Colors.white;
        break;
      case ToastType.error:
        bgColor = Colors.red;
        txtColor = Colors.white;
        break;
      case ToastType.warning:
        bgColor = Colors.orange;
        txtColor = Colors.white;
        break;
      case ToastType.info:
        bgColor = Colors.white;
        txtColor = Colors.black;
        break;
    }

    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: txtColor,
        fontSize: 16.0);
  }
}

bool validateEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

enum ToastType { success, error, warning, info }


extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but the callback has index as second argument
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }

  void forEachIndexed(void Function(int i, E e) f) {
    var i = 0;
    forEach((e) => f(i++, e));
  }
}

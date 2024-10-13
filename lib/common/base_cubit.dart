import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:pixabay_image_setu/utils/utils.dart';

mixin BaseCubit<T> on Cubit<T> {
  var logger = Logger(
    filter: null, // Use the default LogFilter (-> only log in debug mode)
    printer: PrettyPrinter(), // Use the PrettyPrinter to format and print log
    output: null, // Use the default LogOutput (-> send everything to console)
  );

  Future<bool> checkConnection() async {
    return await InternetConnectivityHelper.checkInternetConnectivity();
  }

  Future navigateTo(BuildContext context, String destination, {Object? args}) {
    return Navigator.pushNamed(context, destination, arguments: args);
  }
}

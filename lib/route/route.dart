import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixabay_image_setu/repository/repository.dart';
import 'package:pixabay_image_setu/ui/home_screen/home_screen_bloc.dart';
import 'package:pixabay_image_setu/ui/ui.dart';

class AppRoute {
  //#region Classes Department
  static const String unKnownScreen = '/unKnownScreen';

  //
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen'; //

  //#endregion
  static Route<dynamic> controller(RouteSettings settings) {
    final args = settings.arguments;
    T instanceOf<T>(BuildContext context) {
      return RepositoryProvider.of<T>(context);
    }

    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
            builder: (context) => const SplashScreen(), settings: settings);
      case AppRoute.homeScreen:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) => HomeScreenBloc(
                    instanceOf<UtilsRepository>(context),
                  ),
                  child: ScreenUtilInit(
                    designSize: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height,
                    ),
                    minTextAdapt: true,
                    child: const HomeScreen(),
                  ),
                ),
            settings: settings);

      default:
        return MaterialPageRoute(
            builder: (context) => ScreenUtilInit(
                designSize: Size(
                  MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height,
                ),
                minTextAdapt: true,
                child: const UnknownScreen()),
            settings: settings);
    }
  }
}

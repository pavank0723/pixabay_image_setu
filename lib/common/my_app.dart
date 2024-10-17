import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixabay_image_setu/repository/repository.dart';
import 'package:pixabay_image_setu/res/res.dart';
import 'package:pixabay_image_setu/route/route.dart' as route;

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark, // Dark text for status bar
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // service.initLocalNotification(context); // Initialize local notifications
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (_) => UtilsRepository()),
          ],
          child: MaterialApp(
            initialRoute: route.AppRoute.splashScreen,
            onGenerateRoute: route.AppRoute.controller,
            debugShowCheckedModeBanner: false,
            /*navigatorObservers: [FlutterSmartDialog.observer],
            builder: FlutterSmartDialog.init(
              loadingBuilder: (String msg) => const CustomLoading(type: 1),
            ),*/
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
              canvasColor: Colors.transparent,
              dialogTheme: const DialogTheme(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.white,
              ),
              textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
              elevatedButtonTheme:
                  ElevatedButtonThemeData(style: raisedButtonStyle),
              outlinedButtonTheme:
                  OutlinedButtonThemeData(style: outlineButtonStyle),
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primary,
                primaryContainer: Colors.white,
                error: AppColors.error,
                onTertiary: AppColors.warning,
                surface: Colors.white,
              ),
              cardTheme: CardTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: AppColors.primary),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                elevation: 0,
              ),
              inputDecorationTheme: const InputDecorationTheme(
                  filled: true,
                  fillColor: AppColors.primaryLightest,
                  focusColor: AppColors.primary),
            ),
          ),
        );
      });
    });
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
  ),
);

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
  ),
);

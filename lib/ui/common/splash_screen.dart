import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixabay_image_setu/common/common.dart';
import 'package:pixabay_image_setu/route/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with BasePageState {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(seconds: 2), () async {
      replaceWith(
        AppRoute.homeScreen,
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          width: size.width * 0.8,
          height: size.height * 0.95,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          alignment: Alignment.center,
          child: const Text("Splash Screen"),
          // child: Text("GoCamle"),
        ),
      ),
    );
  }
}

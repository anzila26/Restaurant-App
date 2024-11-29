import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/static/navigation_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, NavigationRoute.mainRoute.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Image.asset(
                "assets/images/logo-resto.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox.square(dimension: 20.0),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'animation.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateSplash(),
    );
  }
}
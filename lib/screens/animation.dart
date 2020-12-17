import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';

class AnimateSplash extends StatefulWidget {
  @override
  _AnimateSplashState createState() => _AnimateSplashState();
}

class _AnimateSplashState extends State<AnimateSplash> {
  Tween<double> tween = Tween(begin: 0.0, end: 1.0);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 2),
        tween: tween,
        builder: (BuildContext context, double opacity, Widget child) {
          return Opacity(
            opacity: opacity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: size.width * 0.26,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Weather ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Forecast',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onEnd: () {
          Get.off(HomeScreen());
        },
      ),
    );
  }
}
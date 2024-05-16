import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:findam/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const SplashScreen());

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Code',
      home: AnimatedSplashScreen(
        duration: 4000,
        splash: Image.asset('assets/img/logo.png'),
        nextScreen: const MainScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        splashIconSize: 250,
      ),
    );
  }
}

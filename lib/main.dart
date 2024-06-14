import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:findam/home_screen.dart';
import 'package:findam/item_info_screen.dart';
import 'package:findam/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(const SplashScreen());

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sora',
      ),
      title: 'FindAm',
      home: AnimatedSplashScreen(
        duration: 3000, //Set to 3000
        splash: Image.asset('assets/img/logo.png'),
        nextScreen: const SignInScreen(), //Set to SignInScreen()
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        animationDuration: Durations.extralong4,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        splashIconSize: 250,
      ),
    );
  }
}

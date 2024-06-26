import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:findam/home_screen.dart';
import 'package:findam/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SplashScreen());
}

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
        duration: 3000,
        splash: Image.asset('assets/img/logo.png'),
        nextScreen: SignInScreen(),
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.leftToRightWithFade,
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        splashIconSize: 250,
      ),
    );
  }
}

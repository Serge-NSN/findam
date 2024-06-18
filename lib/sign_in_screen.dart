import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:findam/home_screen.dart';
import 'package:findam/sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF101010),
      ),
      body: Container(
        color: const Color(0xFF101010),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'SIGN IN',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom > 0
                ? const SizedBox(height: 8)
                : const SizedBox(height: 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? const SizedBox(height: 15)
                        : const SizedBox(height: 70),
                    TextField(
                      controller: emailController,
                      cursorColor: Color.fromARGB(192, 255, 255, 255),
                      decoration: InputDecoration(
                        labelText: 'E-mail Address',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                      ),
                      style: TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      cursorColor: Color.fromARGB(192, 255, 255, 255),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                        helperText: 'At least 8 characters',
                      ),
                      style: TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 20),
                    const Text('Forgot my password',
                        style: TextStyle(
                            color: Color(0xFFED873D),
                            fontSize: 12,
                            fontWeight: FontWeight.w200)),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(13)),
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromRGBO(254, 235, 234, 1))),
                        onPressed: () async {
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided.');
                            }
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'OR',
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFB1B1B1)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Add Google/Facebook Sign-In buttons here
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontFamily: 'Sora', color: Colors.white70),
                          children: <TextSpan>[
                            const TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(
                                color: Color(0xFFED873D),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

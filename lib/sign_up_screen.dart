import 'package:findam/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                'SIGN UP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            MediaQuery.of(context).viewInsets.bottom > 0
                ? const SizedBox(height: 8) // add gap when keyboard is present
                : const SizedBox(height: 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? const SizedBox(
                            height:
                                15) // Reduce the SizedBox when keyboard is present
                        : const SizedBox(height: 70),
                    const TextField(
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
                    const TextField(
                      cursorColor: Color.fromARGB(192, 255, 255, 255),
                      obscureText: true,
                      // obscuringCharacter: '*',
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
                        onPressed: () {},
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Text(
                          'Continue with ',
                          style: TextStyle(color: Colors.black),
                        ),
                        label: Image.asset('assets/img/google-logo.png',
                            height: 18),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(248, 251, 255, 1),
                          ),
                        ),
                        onPressed: () {
                          // onPressed code
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Text(
                          'Continue with ',
                          style: TextStyle(color: Colors.black),
                        ),
                        label: const Icon(
                          Icons.facebook,
                          size: 24,
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(248, 251, 255, 1),
                          ),
                        ),
                        onPressed: () {
                          // Your onPressed code
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontFamily: 'Sora',
                              color: Colors
                                  .white70), // Default text style for other text
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an account? "),
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                color: Color(0xFFED873D),
                              ), // Orange text style for 'Register'
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignInScreen()),
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

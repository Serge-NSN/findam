import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:findam/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneController =
      TextEditingController(text: '+237');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    phoneFocusNode.addListener(() {
      if (phoneFocusNode.hasFocus && !phoneController.text.startsWith('+237')) {
        phoneController.text = '+237';
        phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length),
        );
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

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
                ? const SizedBox(height: 8)
                : const SizedBox(height: 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MediaQuery.of(context).viewInsets.bottom > 0
                        ? const SizedBox(height: 8)
                        : const SizedBox(height: 15),
                    const TextField(
                      cursorColor: Color.fromARGB(192, 255, 255, 255),
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                      ),
                      style: TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      cursorColor: Color.fromARGB(192, 255, 255, 255),
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                        helperText: 'Eg. +237xxxxxxxxx',
                      ),
                      style: TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
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
                                .createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    ),
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

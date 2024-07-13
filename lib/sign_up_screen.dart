import 'package:findam/home_screen.dart';
import 'package:findam/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(text: '+237');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  OverlayEntry? _overlayEntry; // Store the OverlayEntry
  bool _isProcessing = false; // Track whether sign up is in progress

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

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    phoneFocusNode.dispose();
    _animationController.dispose();
    _overlayEntry?.remove(); // Remove the OverlayEntry when disposing
    super.dispose();
  }

  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 12 && phoneNumber.startsWith('237');
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }

  void showTopSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    _overlayEntry
        ?.remove(); // Remove any existing OverlayEntry before adding new one
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).viewInsets.top + 50,
        left: 20,
        right: 20,
        child: SlideTransition(
          position: _slideAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      _animationController.reverse();
                      Future.delayed(const Duration(milliseconds: 300), () {
                        _overlayEntry?.remove();
                        _overlayEntry = null;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
    _animationController.reset();
    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      _animationController.reverse();
      Future.delayed(const Duration(milliseconds: 300), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
      });
    });
  }

  Future<void> signUp() async {
    setState(() {
      _isProcessing = true; // Set state to indicate sign up is in progress
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.isEmpty
            ? '${phoneController.text}@dummy.com'
            : emailController.text,
        password: passwordController.text,
      );

      // Show success message
      showTopSnackBar(context, 'Successful registration!');

      // Delay to simulate a network call or other processing
      await Future.delayed(Duration(seconds: 3));

      // Navigate to home screen after successful sign up
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showTopSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showTopSnackBar(context, 'An account already exists for that email.');
      } else {
        showTopSnackBar(context, 'Error: ${e.message}');
      }
    } catch (e) {
      showTopSnackBar(context, 'An error occurred. Please try again.');
    } finally {
      setState(() {
        _isProcessing = false; // Reset state after sign up attempt
      });
    }
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: fullNameController,
                      cursorColor: const Color.fromARGB(192, 255, 255, 255),
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                      ),
                      style: const TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      cursorColor: const Color.fromARGB(192, 255, 255, 255),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                        _PhoneNumberFormatter(),
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                        helperText: 'Eg. +237xxxxxxxxx',
                      ),
                      style: const TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: emailController,
                      cursorColor: const Color.fromARGB(192, 255, 255, 255),
                      decoration: const InputDecoration(
                        labelText: 'E-mail Address',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                      ),
                      style: const TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
                      cursorColor: const Color.fromARGB(192, 255, 255, 255),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                        helperText: 'At least 8 characters',
                      ),
                      style: const TextStyle(color: Color(0xFFB1B1B1)),
                    ),
                    const SizedBox(height: 70),
                    SizedBox(
                      width: double.infinity,
                      child: _isProcessing
                          ? Center(
                              child: CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromRGBO(254, 235, 234, 1),
                                color: Colors.black,
                              ),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(13),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  const Color.fromRGBO(254, 235, 234, 1),
                                ),
                              ),
                              onPressed: () {
                                if (fullNameController.text.isEmpty) {
                                  showTopSnackBar(
                                      context, 'Full Name is required.');
                                  return;
                                }

                                if (!isValidPhoneNumber(phoneController.text)) {
                                  showTopSnackBar(context,
                                      'Please enter a valid phone number.');
                                  return;
                                }

                                if (!isValidPassword(passwordController.text)) {
                                  showTopSnackBar(context,
                                      'Password must be at least 8 characters long.');
                                  return;
                                }

                                signUp(); // Call async sign-up method
                              },
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Sora',
                            color: Colors.white70,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                              text: "Already have an account? ",
                            ),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: Color(0xFFED873D),
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInScreen(),
                                    ),
                                  );
                                },
                            ),
                          ],
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

class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 13) {
      return oldValue;
    }
    return newValue;
  }
}

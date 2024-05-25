import 'package:findam/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneController =
      TextEditingController(text: '+237');
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
                      textCapitalization: TextCapitalization.characters,
                    ),
                    TextFormField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      cursorColor: const Color.fromARGB(192, 255, 255, 255),
                      decoration: const InputDecoration(
                        labelText:
                            'Phone Number *', // Add an asterisk to indicate it's required
                        labelStyle: TextStyle(
                          color: Color(0xFFB1B1B1),
                        ),
                      ),
                      style: const TextStyle(color: Color(0xFFB1B1B1)),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(13),
                        FilteringTextInputFormatter.allow(RegExp(r'[\d+]')),
                      ],
                      validator: (value) {
                        if (value!.length <= 13) {
                          return 'Please enter a phone number';
                        }
                        // You can add additional validation logic here if needed.
                        return null; // Return null if validation passes.
                      },
                      onChanged: (value) {
                        if (!value.startsWith('+237')) {
                          phoneController.text = '+237';
                          phoneController.selection =
                              TextSelection.fromPosition(
                            TextPosition(offset: phoneController.text.length),
                          );
                        }
                      },
                    ),
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
                    const TextField(
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
                          'Sign Up',
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
                          'Continue with',
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
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Text(
                          'Continue with',
                          style: TextStyle(color: Colors.black),
                        ),
                        label: const Icon(
                          Icons.facebook,
                          size: 24,
                          color: Color.fromARGB(221, 30, 43, 238),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(248, 251, 255, 1),
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontFamily: 'Sora', color: Colors.white70),
                          children: <TextSpan>[
                            const TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: 'Login',
                              style: const TextStyle(
                                color: Color(0xFFED873D),
                              ),
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

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/resources/auth_methods.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/responsive/web_screen_layout.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class Forgetpass extends StatefulWidget {
  const Forgetpass({Key? key}) : super(key: key);

  @override
  State<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends State<Forgetpass> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fourdColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              //container to photo and word(register)

              Container(
                decoration: const BoxDecoration(
                  color: thirdColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(150, 30)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                height: 500,
                // this column about all textfield
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),

                      //textfield email
                      TextFieldInbut(
                          iconTexfield: Icons.email,
                          textEditingController: _emailController,
                          hintText: "Enter your email",
                          textInputType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 24,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      //button signUp
                      InkWell(
                          onTap: () {
                            FirebaseAuth.instance
                                .sendPasswordResetEmail(
                                    email: _emailController.text)
                                .then((value) => Navigator.of(context).pop());
                          },
                          child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  color: Color.fromARGB(190, 237, 201, 175)),
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: primaryColor,
                                      ),
                                    )
                                  : const Text(
                                      "reset",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ))),

                      const SizedBox(
                        height: 40,
                      ),

                      //Transitioning to Log in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "if you have an account?",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: navigateToLogin,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  " Log in.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        ));
  }
}

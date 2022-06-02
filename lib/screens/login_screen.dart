//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:housing/resources/auth_methods.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/screens/forget_pass.dart';
import 'package:housing/screens/signup_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool ispass = true;
  IconData iconShowPass = Icons.remove_red_eye;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  void navigateToForgetpass() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Forgetpass()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: fourdColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///
                const SizedBox(
                  height: 15,
                ),
                //png image
                Stack(
                  children: const [
                    Image(
                      image: AssetImage('assets/images/4.png'),
                      height: 220,
                    ),
                    Positioned(
                      bottom: 60,
                      right: 130,
                      child: Text(
                        "Housing",
                        style: TextStyle(
                            fontFamily: "cursive",
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: primaryColor),
                      ),
                    ),
                  ],
                ),

                ///
                Container(
                  padding: const EdgeInsets.all(35),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: thirdColor,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //textfield email
                      TextFieldInbut(
                          iconTexfield: Icons.email,
                          textEditingController: _emailController,
                          hintText: "Enter your email",
                          textInputType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 24,
                      ),
                      //texfield pass
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            hintText: "Enter your password",
                            border: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(context)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(context)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: Divider.createBorderSide(context)),
                            filled: true,
                            contentPadding: const EdgeInsets.all(8),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ispass == true
                                        ? ispass = false
                                        : ispass = true;
                                    iconShowPass == Icons.remove_red_eye
                                        ? iconShowPass =
                                            Icons.remove_red_eye_outlined
                                        : iconShowPass = Icons.remove_red_eye;
                                  });
                                },
                                icon: Icon(iconShowPass))),
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: ispass,
                      ),

                      const SizedBox(
                        height: 24,
                      ),
                      //button login
                      InkWell(
                        onTap: loginUser,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            color: Color.fromARGB(190, 237, 201, 175),
                          ),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: thirdColor,
                                ))
                              : const Text(
                                  "log in",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                      //Transitioning to forgetpass
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "If you forgot your password?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                              onTap: navigateToForgetpass,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  " Forgot.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ))
                        ],
                      ),
                      //Transitioning to signning in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: const Text(
                              "Dont't have an account?",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                              onTap: navigateToSignup,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: const Text(
                                  " Sign up.",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}

//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:housing/resources/auth_methods.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/responsive/web_screen_layout.dart';
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
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
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
        .push(MaterialPageRoute(builder: (context) => SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blueColor,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///
                const SizedBox(
                  height: 15,
                ),
                //png image
                ///
                const Image(
                  image: AssetImage('assets/images/4.png'),
                  height: 220,
                ),

                ///
                Container(
                  padding: const EdgeInsets.all(35),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.black,
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
                              child: _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ))
                                  : const Text("log in"),
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  color: blueColor))),

                      const SizedBox(
                        height: 40,
                      ),

                      //Transitioning to signning in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: const Text("Dont't have an account?"),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          GestureDetector(
                              onTap: navigateToSignup,
                              child: Container(
                                child: const Text(
                                  " Sign up.",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                              ))
                        ],
                      ),
                      //
                      /*  const SizedBox(
                        height: 600,
                      ), */
                    ],
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}

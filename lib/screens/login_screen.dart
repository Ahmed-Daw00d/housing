import 'package:flutter/material.dart';
import 'package:housing/resources/auth_methods.dart';
import 'package:housing/screens/home_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';

import 'package:housing/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
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
    if (res == "success") {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //png image
            const Image(
              image: AssetImage('assets/images/4.png'),
              height: 220,
            ),
            const SizedBox(
              height: 64,
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
            //texfield pass
            TextFieldInbut(
              iconTexfield: Icons.vpn_key_rounded,
              textEditingController: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.visiblePassword,
              ispass: ispass,
            ),
            //show pass
            TextButton.icon(
                onPressed: () {
                  setState(() {
                    ispass == true ? ispass = false : ispass = true;
                    iconShowPass == Icons.remove_red_eye
                        ? iconShowPass = Icons.remove_red_eye_outlined
                        : iconShowPass = Icons.remove_red_eye;
                  });
                },
                icon: Icon(iconShowPass),
                label: const Text("Show Password")),
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
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: blueColor))),

            const SizedBox(
              height: 100,
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
                    onTap: () {},
                    child: Container(
                      child: const Text(
                        " Sign up.",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ))
              ],
            )
          ],
        ),
      )),
    ));
  }
}

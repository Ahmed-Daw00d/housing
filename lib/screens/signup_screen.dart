import 'dart:typed_data';
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

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethod().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      file: _image!,
    );
    setState(() {
      _isLoading = false;
    });

    if (res != 'succes') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreen()));
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
            //register text
            const Text(
              "Register",
              style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),

            const SizedBox(
              height: 30,
            ),
            //circular Widget to accept and show our selected file
            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIy2vRwSRoUACatub962auO36Uo5OjNQ5wCQ&usqp=CAU'),
                      ),
                Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            //textfield username
            TextFieldInbut(
                iconTexfield: Icons.person,
                textEditingController: _usernameController,
                hintText: "Enter your username",
                textInputType: TextInputType.text),
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
            //texfield pass
            TextFieldInbut(
              iconTexfield: Icons.vpn_key_rounded,
              textEditingController: _passwordController,
              hintText: "Enter your password",
              textInputType: TextInputType.visiblePassword,
              ispass: false,
            ),
            const SizedBox(
              height: 24,
            ),
            //textfield ti input pio
            TextFieldInbut(
                iconTexfield: Icons.person_add,
                textEditingController: _bioController,
                hintText: "Enter your bio",
                textInputType: TextInputType.text),
            const SizedBox(
              height: 64,
            ),
            //button login
            InkWell(
                onTap: signUpUser,
                child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text("Sign Up"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        color: blueColor))),

            const SizedBox(
              height: 12,
            ),

            //Transitioning to Log in
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("if you have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text(
                        " Log in.",
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

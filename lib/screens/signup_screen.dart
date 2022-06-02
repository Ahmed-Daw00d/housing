import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:housing/resources/auth_methods.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _bioController = "";
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;

  Uint8List? _IdImage;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void selectIdImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _IdImage = im;
    });
  }

  void signUpUser() async {
    setState(() {
      if (_emailController.text.isEmpty ||
          _passwordController.text.isEmpty ||
          _usernameController.text.isEmpty ||
          _bioController.isEmpty ||
          _image!.isEmpty ||
          _IdImage!.isEmpty) {
        _isLoading = false;
        showSnackBar("Please enter all data", context);
      } else {
        _isLoading = true;
      }
    });

    // signup user using our authmethodds
    String res = await AuthMethod().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController,
        file: _image!,
        IdImage: _IdImage!);

    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: MobileScreenLayout(),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      // ignore: use_build_context_synchronously
      showSnackBar(res, context);
    }
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
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    //register text
                    const Text(
                      "Housing",
                      style: TextStyle(
                          fontFamily: "cursive",
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: thirdColor),
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
                  ],
                ),
              ),
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
                      //student or lessor
                      Column(
                        children: [
                          //student
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  setState(() {
                                    {
                                      _bioController = "student";
                                    }
                                  });
                                },
                                icon: const Image(
                                    width: 50,
                                    height: 40,
                                    image: AssetImage(
                                        'assets/images/student.png')),
                                label: const Text(
                                  "student",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),

                              const SizedBox(
                                width: 50,
                                child: Center(
                                  child: Text(
                                    "or",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: primaryColor),
                                  ),
                                ),
                              ),

                              //lessor
                              TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      {
                                        _bioController = "lessor";
                                      }
                                    });
                                  },
                                  icon: const Image(
                                      width: 50,
                                      height: 40,
                                      image: AssetImage(
                                          'assets/images/lessor.png')),
                                  label: const Text(
                                    "owner",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ))
                            ],
                          ),
                          //
                          if (_bioController == "student")
                            Column(
                              children: [
                                const Text("Enter your Student ID"),
                                IconButton(
                                    onPressed: selectIdImage,
                                    icon: const Icon(Icons.assignment_ind))
                              ],
                            )
                          else if (_bioController == "lessor")
                            Column(
                              children: [
                                const Text("Enter your Personal ID"),
                                IconButton(
                                    onPressed: selectIdImage,
                                    icon: const Icon(Icons.assignment_ind))
                              ],
                            ),
                        ],
                      ),
                      //
                      const SizedBox(
                        height: 24,
                      ),
                      //button signUp
                      InkWell(
                          onTap: signUpUser,
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
                                      "Sign Up",
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

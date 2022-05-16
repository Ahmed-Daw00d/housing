//import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:housing/models/user.dart';
import 'package:housing/providers/user_provider.dart';

import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../resources/firestore_methods.dart';

class UpdateProf extends StatefulWidget {
  const UpdateProf({Key? key}) : super(key: key);

  @override
  State<UpdateProf> createState() => _UpdateProfState();
}

class _UpdateProfState extends State<UpdateProf> {
  String _bioController = "";
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  // ignore: non_constant_identifier_names

  final bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();

    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  //

  @override
  Widget build(BuildContext context) {
    //
    final User user = Provider.of<UserProvider>(context).getUser;
    //
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
                                      showSnackBar(
                                          "جاري التحويل من مالك الي طالب برجاء الضغط علي تحديث ليتم التحويل",
                                          context);
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
                                        showSnackBar(
                                            "جاري التحويل من طالب الي مالك برجاء الضغط علي تحديث ليتم التحويل",
                                            context);
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
                        ],
                      ),
                      //
                      const SizedBox(
                        height: 24,
                      ),
                      //button signUp
                      InkWell(
                          onTap: () {
                            if (_usernameController.text.isNotEmpty) {
                              FirestoreMethods().updateData(user.uid,
                                  "username", _usernameController.text);
                            } else {
                              showSnackBar("", context);
                            }
                            if (_bioController.isNotEmpty) {
                              FirestoreMethods()
                                  .updateData(user.uid, "bio", _bioController);
                            } else {
                              showSnackBar("", context);
                            }
                            if (_image != null) {
                              FirestoreMethods().updateImage(user.uid, _image);
                            } else {
                              showSnackBar("", context);
                            }
                            showSnackBar("تم التعديل ", context);
                            Navigator.of(context).pop();
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
                                      "update",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ))),

                      const SizedBox(
                        height: 40,
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

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:housing/models/user.dart';
import 'package:housing/providers/user_provider.dart';
import 'package:housing/resources/firestore_methods.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/utils.dart';
import 'package:housing/widgets/text_field_input.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  //
  Uint8List? _file;

  ///
  Uint8List? _file2;
  Uint8List? _file3;
  Uint8List? _file4;
  //
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _adjacentController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _specialMarkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
//number
  final TextEditingController _numberController = TextEditingController();
//

  bool _isloading = false;

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text,
          _neighborhoodController.text,
          _adjacentController.text,
          _buildingController.text,
          _apartmentController.text,
          _specialMarkController.text,
          _priceController.text,
          _file,
          uid,
          username,
          profImage,
          _file2,
          _file3,
          _file4,
          _numberController.text);

      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        showSnackBar('Posted', context);
        clearImage();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

//
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  Uint8List file2 = await pickImage(ImageSource.camera);
                  Uint8List file3 = await pickImage(ImageSource.camera);
                  Uint8List file4 = await pickImage(ImageSource.camera);

                  setState(() {
                    _file = file;
                    _file2 = file2;
                    _file3 = file3;
                    _file4 = file4;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  Uint8List file2 = await pickImage(ImageSource.gallery);
                  Uint8List file3 = await pickImage(ImageSource.gallery);
                  Uint8List file4 = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
                    _file2 = file2;
                    _file3 = file3;
                    _file4 = file4;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  //
  void clearImage() {
    setState(() {
      _file = null;
      _file2 = null;
      _file3 = null;
      _file4 = null;
    });
  }

  @override
  //
  void dispose() {
    super.dispose();
    _adjacentController.dispose();
    _apartmentController.dispose();
    _buildingController.dispose();
    _descriptionController.dispose();
    _neighborhoodController.dispose();
    _priceController.dispose();
    _specialMarkController.dispose();
  }

//
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return (_file == null)
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.upload),
                  onPressed: () => _selectImage(context),
                ),
              ],
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: thirdColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clearImage,
              ),
              title: const Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(user.uid, user.username, user.photoUrl);
                    showSnackBar(
                        "???????? ?????????? ?????????? ???????????????? ?????? ???????? ?????????????? ", context);
                  },
                  child: const Text(
                    "post",
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _isloading
                      ? const LinearProgressIndicator()
                      : const Padding(padding: EdgeInsets.only(top: 0)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.photoUrl),
                      ),
                      //
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //the data for the apartment  ???????????????? ?????????? ??????????
                              TextFieldPost(
                                  textEditingController: _descriptionController,
                                  hintText: "??....(????????????????)",
                                  maxLines: 8),
                              TextFieldPost(
                                  textEditingController:
                                      _neighborhoodController,
                                  hintText: "....(????????)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _adjacentController,
                                  hintText: "....(????????????????)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _buildingController,
                                  hintText: "....(?????? ??????????????)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _apartmentController,
                                  hintText: "....(?????? ??????????)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _specialMarkController,
                                  hintText: "....(?????????? ??????????)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _priceController,
                                  hintText: "....(??????????)",
                                  maxLines: 1),
                              //number
                              TextFieldPost(
                                  hintText: "....?????? ??????????????",
                                  maxLines: 1,
                                  textEditingController: _numberController),

                              const Divider(),

                              //Image   ?????? ??????????

                              Column(
                                children: [
                                  SizedBox(
                                    height: 220,
                                    width: 320,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: MemoryImage(_file!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),

                                  ///
                                  //image 2
                                  SizedBox(
                                    height: 220,
                                    width: 320,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: MemoryImage(_file2!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  //image3
                                  SizedBox(
                                    height: 220,
                                    width: 320,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: MemoryImage(_file3!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  //  image4
                                  SizedBox(
                                    height: 220,
                                    width: 320,
                                    child: AspectRatio(
                                      aspectRatio: 487 / 451,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: MemoryImage(_file4!),
                                              fit: BoxFit.fill,
                                              alignment:
                                                  FractionalOffset.topCenter),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}

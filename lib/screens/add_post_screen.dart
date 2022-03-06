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
  //
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _adjacentController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _specialMarkController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
//
  void postImage(String uid, String username, String profImage) async {
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
      );

      if (res == "success") {
        showSnackBar('Posted!', context);
      } else {
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

                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);

                  setState(() {
                    _file = file;
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
                onPressed: () {},
              ),
              title: const Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.username, user.photoUrl),
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
                              //the data for the apartment  البيانات بتاعت الشقه
                              TextFieldPost(
                                  textEditingController: _descriptionController,
                                  hintText: "ًWrite a caption....(التفاصيل)",
                                  maxLines: 8),
                              TextFieldPost(
                                  textEditingController:
                                      _neighborhoodController,
                                  hintText: "The neighborhood....(الحي)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _adjacentController,
                                  hintText: "The adjacent....(المجاوره)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _buildingController,
                                  hintText:
                                      "The building number....(رقم العماره)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _apartmentController,
                                  hintText: "Apartment number....(رقم الشقه)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _specialMarkController,
                                  hintText:
                                      "A special place or mark....(علامه مميزه)",
                                  maxLines: 1),
                              TextFieldPost(
                                  textEditingController: _priceController,
                                  hintText: "Price....(السعر)",
                                  maxLines: 1),

                              //Image   صور الشقه
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

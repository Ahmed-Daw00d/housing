import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housing/models/post.dart';
import 'package:housing/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';
import 'package:web_ffi/web_ffi.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String description,
    String neighborhood,
    String adjacent,
    String building,
    String apartment,
    String specialMark,
    String price,
    var file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "some error occurred";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      String postId = const Uuid().v1();
      Post post = Post(
          description: description,
          adjacent: adjacent,
          apartment: apartment,
          building: building,
          datePublished: DateTime.now(),
          likes: [],
          neighborhood: neighborhood,
          postId: postId,
          postUrl: photoUrl,
          price: price,
          profImage: profImage,
          specialMark: specialMark,
          uid: uid,
          username: username);

      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}

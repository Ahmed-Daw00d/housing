import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housing/models/post.dart';
import 'package:housing/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

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
    //
    var file2,
    var file3,
    var file4,
    //number
    String number,
  ) async {
    String res = "some error occurred";

    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      //
      String photoUrl2 =
          await StorageMethods().uploadImageToStorage("posts", file2, true);
      String photoUrl3 =
          await StorageMethods().uploadImageToStorage("posts", file3, true);
      String photoUrl4 =
          await StorageMethods().uploadImageToStorage("posts", file4, true);

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
        username: username,
        //
        postUrl2: photoUrl2,
        postUrl3: photoUrl3,
        postUrl4: photoUrl4,
        //number
        number: number,
      );

      _firestore.collection("posts").doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//
  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection("posts").doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //
  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

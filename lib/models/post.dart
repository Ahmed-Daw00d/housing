import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String neighborhood;
  final String adjacent;
  final String building;
  final String apartment;
  final String specialMark;
  final String price;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.adjacent,
    required this.apartment,
    required this.building,
    required this.datePublished,
    required this.description,
    required this.likes,
    required this.neighborhood,
    required this.postId,
    required this.postUrl,
    required this.price,
    required this.profImage,
    required this.specialMark,
    required this.uid,
    required this.username,
  });

  Map<String, dynamic> toJson() => {
        "adjacent": adjacent,
        'apartment': apartment,
        'building': building,
        'datePublished': datePublished,
        'description': description,
        'likes': likes,
        'neighborhood': neighborhood,
        'postId': postId,
        'postUrl': postUrl,
        'price': price,
        'profImage': profImage,
        'specialMark': specialMark,
        'uid': uid,
        'username': username,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      username: snapshot['username'],
      adjacent: snapshot['adjacent'],
      apartment: snapshot['apartment'],
      building: snapshot['building'],
      uid: snapshot['uid'],
      datePublished: snapshot['datePublished'],
      description: snapshot['description'],
      likes: snapshot['likes'],
      neighborhood: snapshot['neighborhood'],
      postId: snapshot['postId'],
      postUrl: snapshot['postUrl'],
      price: snapshot['price'],
      profImage: snapshot['profImage'],
      specialMark: snapshot['specialMark'],
    );
  }
}

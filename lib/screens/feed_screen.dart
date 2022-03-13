import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housing/models/user.dart';
import 'package:housing/providers/user_provider.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/widgets/post_card.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: fourdColor,
      appBar: AppBar(
        backgroundColor: thirdColor,
        centerTitle: false,
        title: const Text("Housing",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontFamily: "cursive",
                fontSize: 30)),
        actions: [
          Center(
            child: Text(
              "Nickname: ${user.bio} ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                    snap: snapshot.data!.docs[index].data(),
                  ));
        },
      ),
    );
  }
}

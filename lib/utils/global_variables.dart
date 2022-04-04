import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housing/screens/add_post_screen.dart';
import 'package:housing/screens/feed_screen.dart';
import 'package:housing/screens/profile_screen.dart';
import 'package:housing/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> lessorHomeScreenItems = [
  const FeedScreen(), //homeScreen
  const SearchScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  const AddPostScreen(),
];

List<Widget> studentHomeScreenItems = [
  const FeedScreen(), //homeScreen
  const SearchScreen(),

  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];

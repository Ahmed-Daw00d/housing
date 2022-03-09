import 'package:flutter/material.dart';
import 'package:housing/screens/add_post_screen.dart';
import 'package:housing/screens/feed_screen.dart';
import 'package:housing/screens/profile.dart';

const webScreenSize = 600;

const lessorHomeScreenItems = [
  FeedScreen(), //homeScreen
  Center(child: Text("search")),
  Center(child: Text("favorite")),
  Profile(),
  AddPostScreen(),
];

const studentHomeScreenItems = [
  FeedScreen(), //homeScreen
  Center(child: Text("search")),
  Center(child: Text("favorite")),
  Profile(),
];

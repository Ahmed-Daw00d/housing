import 'package:flutter/material.dart';
import 'package:housing/screens/add_post_screen.dart';
import 'package:housing/screens/profile.dart';

const webScreenSize = 600;

const homeScreenItems = [
  Center(child: Text("home")),
  AddPostScreen(),
  Center(child: Text("search")),
  Center(child: Text("favorite")),
  Profile(),
];

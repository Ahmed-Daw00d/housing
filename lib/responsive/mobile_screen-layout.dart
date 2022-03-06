import 'package:flutter/material.dart';
import 'package:housing/screens/add_post_screen.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/screens/profile.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          //0
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: (_page == 0) ? blueColor : secondaryColor),
            label: "",
            backgroundColor: mobileBackgroundColor,
          ),
          //1
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,
                color: (_page == 1) ? blueColor : secondaryColor),
            label: "",
            backgroundColor: mobileBackgroundColor,
          ),
          //2
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: (_page == 2) ? blueColor : secondaryColor),
            label: "",
            backgroundColor: mobileBackgroundColor,
          ),
          //3
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: (_page == 3) ? blueColor : secondaryColor),
            label: "",
            backgroundColor: mobileBackgroundColor,
          ),
          //4
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
                color: (_page == 4) ? blueColor : secondaryColor),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}

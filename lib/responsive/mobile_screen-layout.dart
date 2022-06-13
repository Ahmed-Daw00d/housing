import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:housing/utils/colors.dart';
import 'package:housing/utils/global_variables.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';

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
    User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: user.bio == 'lessor'
            ? lessorHomeScreenItems
            : studentHomeScreenItems,
      ),
      bottomNavigationBar: user.bio == "lessor"
          ? CurvedNavigationBar(
              color: thirdColor,
              height: 50,
              backgroundColor: fourdColor,
              items: <Widget>[
                //0
                Icon(Icons.home,
                    color: (_page == 0) ? blueColor : secondaryColor),
                //1 add post
                Icon(Icons.search,
                    color: (_page == 1) ? blueColor : secondaryColor),
                //2
                Icon(Icons.person,
                    color: (_page == 2) ? blueColor : secondaryColor),
                //3
                Icon(Icons.add_circle,
                    color: (_page == 3) ? blueColor : secondaryColor),
              ],
              onTap: navigationTapped,
            )
          : CurvedNavigationBar(
              color: thirdColor,
              height: 50,
              backgroundColor: fourdColor,
              items: [
                //0
                Icon(Icons.home,
                    color: (_page == 0) ? blueColor : secondaryColor),
                //1 add post
                Icon(Icons.search,
                    color: (_page == 1) ? blueColor : secondaryColor),
                //2
                Icon(Icons.person,
                    color: (_page == 2) ? blueColor : secondaryColor),
              ],
              onTap: navigationTapped,
            ),
    );
  }
}

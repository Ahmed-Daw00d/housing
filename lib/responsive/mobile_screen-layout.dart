import 'package:flutter/material.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/utils/colors.dart';

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
      // delet
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ),
        ],
      ),
      //
      body: PageView(
        children: const [
          Center(child: Text("home")),
          Center(child: Text("add")),
          Center(child: Text("search")),
          Center(child: Text("favorite")),
          Center(child: Text("profile")),
        ],
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

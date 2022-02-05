import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/responsive/web_screen_layout.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/screens/signup_screen.dart';
import 'package:housing/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAkQ_TjJVztShs-SkxzL26EUXV1n3WMvn0',
      appId: "1:797122427539:web:4e789ef6649b62964dab66",
      messagingSenderId: "797122427539",
      projectId: "housing-82acb",
      storageBucket: "housing-82acb.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Housing ',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      /* home: const ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout()),*/
      home: LoginScreen(),
    );
  }
}

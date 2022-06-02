import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:housing/providers/user_provider.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/screens/login_screen.dart';
import 'package:housing/utils/colors.dart';
import 'package:provider/provider.dart';
//
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyDDHLaATVhkSwIjtE3UTv50NM3BdAErR9M',
      appId: "1:1064638998112:web:c50ff64796d43ab5034505",
      messagingSenderId: "1064638998112",
      projectId: "housing-60e4f",
      storageBucket: "housing-60e4f.appspot.com",
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Housing ',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                    webScreenLayout: MobileScreenLayout(),
                    mobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return AnimatedSplashScreen(
              splash: Image.asset("assets/images/3.png"),
              splashIconSize: 300,
              nextScreen: const LoginScreen(),
              splashTransition: SplashTransition.scaleTransition,
              backgroundColor: const Color.fromARGB(255, 240, 146, 59),
            );
          },
        ),
      ),
    );
  }
}

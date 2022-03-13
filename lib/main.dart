import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:housing/providers/user_provider.dart';
import 'package:housing/responsive/mobile_screen-layout.dart';
import 'package:housing/responsive/responsive_layout_screen.dart';
import 'package:housing/responsive/web_screen_layout.dart';
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
                    webScreenLayout: WebScreenLayout(),
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
              backgroundColor: Color.fromARGB(255, 240, 146, 59),
            );
          },
        ),
      ),
    );
  }
}

/*
* This is my To-Do app to list the tasks and mark them as done
* Author: Jai Irkal
* Date of Completion: 21/10/22
* Libraries used: animated_splash_screen, flutter_launcher_icons
*
*/
import 'package:flutter/material.dart';
import 'package:untitled/screens/home.dart';
import 'constants/colors.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-Do App",
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/icon.png'),
        nextScreen: Home(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: appBarColor,
        duration: 3000,
      ),
    );
  }
}

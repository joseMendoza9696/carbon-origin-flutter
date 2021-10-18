import 'package:flutter/material.dart';
import 'package:signin_signup/Screens/Home/home_screen.dart';
import 'package:signin_signup/Screens/Welcome/welcome_screen.dart';
import 'package:signin_signup/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      // home: HomeScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup/Screens/Welcome/welcome_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferences();
  }
  _loadPreferences() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? '';
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    setState(() {
      email = decodedToken['email'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Welcome to home page $email'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove("token");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return WelcomeScreen();
              },
            ),
          );
        },
        child: const Text('Logout'),
      ),
    );
  }
}
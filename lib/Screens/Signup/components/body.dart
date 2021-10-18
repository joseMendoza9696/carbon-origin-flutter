import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signin_signup/Screens/Home/home_screen.dart';
import 'package:signin_signup/Screens/Login/login_screen.dart';
import 'package:signin_signup/Screens/Signup/components/background.dart';
import 'package:signin_signup/Screens/Signup/components/or_divider.dart';
import 'package:signin_signup/Screens/Signup/components/social_icon.dart';
import 'package:signin_signup/components/already_have_an_account_acheck.dart';
import 'package:signin_signup/components/rounded_button.dart';
import 'package:signin_signup/components/rounded_input_field.dart';
import 'package:signin_signup/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

var url = Uri.parse('https://carbon-origins-backend.herokuapp.com/signup');

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String email = '';
    String password = '';

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                email = value;
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                Map data = {
                  'email': email,
                  'password': password
                };
                var body = json.encode(data);
                var response = await http.post(
                  url, 
                  headers: {"Content-Type": "application/json"},
                  body: body
                );
                Map<String, dynamic> res = jsonDecode(response.body);

                if ( response.statusCode == 201 || response.statusCode == 200) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString("token", res['token']);
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    })
                  );
                } else {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Error!'),
                      content: Text('${res['error']}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    )
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

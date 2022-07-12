import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/login.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:myapp/homeScreen.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkuserLogin();
    super.initState();
  }

  noUser() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushNamed(context, LoginScreen.id));
    // do async operation ( api call, auto login)
  }

  userActive() {
    Timer(const Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, HomeScreen.id));
    // do async operation ( api call, auto login)
  }

  Future<void> checkuserLogin() async {
    final _prefs = await SharedPreferences.getInstance();
    final userLoggedin = _prefs.getBool(userKey);
    print(userLoggedin);
    if (userLoggedin == null || userLoggedin == false) {
      noUser();
    } else {
      userActive();
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://i.pinimg.com/564x/de/a0/f3/dea0f3b7f480b1151c08db4a402a43b9.jpg'),
      title: Text(
        "Title",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.grey.shade400,
      showLoader: true,
      loadingText: Text("Loading..."),
      //futureNavigator: futureCall(),
    );
  }
}

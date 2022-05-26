import 'dart:async';

import 'package:cake/providers/auth.dart';
//import 'package:cake/providers/google.dart';
import 'package:cake/screens/homescreen.dart';
import 'package:cake/screens/splsh.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  ///const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            PageTransition(
                child: Consumer<Auth>(
                    builder: (ctx, auth, _) => auth.isAuth
                        ? HomeScreen()
                        : FutureBuilder(
                            builder: (ctx, authResultsnapshot) =>
                                authResultsnapshot.connectionState ==
                                        ConnectionState.waiting
                                    ? Splash()
                                    : AuthScreen(),
                            future: auth.tryAutoLogin(),
                          )),
                type: PageTransitionType.bottomToTop)));
    super.initState();
  }

  Widget build(BuildContext context) {
    print("from splash");

    final deviceSize = MediaQuery.of(context).size;
    return MaterialApp(
        home: Scaffold(
      body: Container(
        height: deviceSize.height,
        width: deviceSize.width,
        child: Stack(
          children: [
            Image.asset(
              "asserts/images/cake.jpg",
              height: deviceSize.height * 0.95,
              width: deviceSize.width,
              fit: BoxFit.cover,
            ),
            Container(
              height: deviceSize.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.3, 0.8],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.brown.shade100])),
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'CakeDA',
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Powered By',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Jaffna  Devolper',
                  style: TextStyle(fontSize: 20, color: Colors.brown),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget screen;
  SplashScreen(this.screen);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3), 
      ()=>Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: 
        (context)=>widget.screen,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
        Center(
          child: Image(
            height: 200.0,
            width: 200.0,
            image: AssetImage(
              'assets/images/onboarding_1.png',
            ),
          ),
        ),
      ),
    );
  }
}
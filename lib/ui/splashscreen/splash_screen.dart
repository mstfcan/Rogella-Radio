import 'package:flutter/material.dart';
import 'package:rogella_radio/ui/home/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animation = Tween(begin: -1, end: 0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
    _controller.forward();
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE5E9EC), Color(0xFFFFFFFF)],
        )),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FadeTransition(
          opacity: _controller.drive(CurveTween(curve: Curves.fastOutSlowIn)),
          child: Image.asset(
            "assets/images/splash_logo.png",
            height: 200,
          ),
        ));
  }
}

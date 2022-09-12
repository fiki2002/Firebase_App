import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashSec = 2000;
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: splashSec),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.redAccent,
            Colors.grey.withOpacity(0.2),
          ],
        ),
      ),
      width: double.maxFinite,
      height: double.maxFinite,
      child: const Center(
        child: Text(
          'We Auth',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

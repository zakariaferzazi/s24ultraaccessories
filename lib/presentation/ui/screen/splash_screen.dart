import 'dart:async';
import 'package:ecommerce/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }

  Future<void> goToNextScreen() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => BottomNavBarScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset('assets/images/logo.png', width: MediaQuery.of(context).size.width * 0.9),
          ),
          const Spacer(),
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "All S24 Ultra Accessories Provided by Amazon",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

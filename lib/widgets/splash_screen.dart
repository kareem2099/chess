import 'package:chess_flutter/widgets/mode_select.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 11),
      () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => ModeSelectionScreen())),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.asset(
                'assets/json/Animation - 1712918232365.json'), // Your Lottie animation file
          ),
          Expanded(
            child: SizedBox(
              width: 250.0,
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'welcome',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'to my chess',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'game ya ayoha',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                  ColorizeAnimatedText(
                    'el baba',
                    textStyle: GoogleFonts.roboto(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  ),
                ],
                isRepeatingAnimation: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

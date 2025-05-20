import 'package:flutter/material.dart';
import 'package:tik_tak_toe/themes/colors.dart';
import 'package:tik_tak_toe/themes/fontstyle.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: primaryColor,
          border: Border.all(color: lineColor),
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "TIK TAC TOE",
                  style: titlefont,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.05),
                Image.asset(
                  "assets/images/tiktactoe.png",
                  height: screenHeight * 0.4,
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: boxColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: Text("Start Game", style: titlefont),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

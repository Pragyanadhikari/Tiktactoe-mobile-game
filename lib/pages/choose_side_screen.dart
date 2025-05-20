import 'package:flutter/material.dart';
import 'package:tik_tak_toe/pages/game_Screen.dart';
import 'package:tik_tak_toe/themes/colors.dart';
import 'package:tik_tak_toe/themes/fontstyle.dart';

class ChooseSideScreen extends StatefulWidget {
  final bool isAI;

  const ChooseSideScreen({super.key, required this.isAI});

  @override
  State<ChooseSideScreen> createState() => _ChooseSideScreenState();
}

class _ChooseSideScreenState extends State<ChooseSideScreen> {
  String selectedSide = "X";

  Widget sideOption(String value, String assetPath) {
    return GestureDetector(
      onTap: () => setState(() => selectedSide = value),
      child: Column(
        children: [
          Image.asset(assetPath, width: 100, fit: BoxFit.cover),
          Transform.scale(
            scale: 1.5,
            child: Radio<String>(
              value: value,
              groupValue: selectedSide,
              activeColor: Colors.green,
              onChanged: (val) => setState(() => selectedSide = val!),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("TIK TAC TOE", style: titlefont),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 10,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pick your side", style: normalTextStyle),
            SizedBox(height: screenHeight * 0.04),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                sideOption('O', 'assets/images/circle.png'),
                SizedBox(width: screenWidth * 0.04),
                sideOption('X', 'assets/images/cross.png'),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                elevation: 10,
                backgroundColor: boxColor,
                shadowColor: const Color.fromARGB(255, 6, 71, 103),
                minimumSize: Size(screenWidth * 0.6, screenHeight * 0.07),
                shape: const StadiumBorder(
                  side: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              onPressed: () {
                if (selectedSide.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        playerSide: selectedSide,
                        isAI: widget.isAI,
                      ),
                    ),
                  );
                }
              },
              child: Text("Start Game", style: buttonTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}

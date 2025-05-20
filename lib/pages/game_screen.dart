import 'package:flutter/material.dart';
import 'package:tik_tak_toe/themes/colors.dart';
import 'package:tik_tak_toe/themes/fontstyle.dart';

class GameScreen extends StatefulWidget {
  final bool isAI;
  final String playerSide;
  const GameScreen({super.key, required this.isAI, required this.playerSide});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  List<int> winningTiles = [];
  String currentPlayer = 'X';
  String winner = '';
  int playerScore = 0;
  int aiScore = 0;
  String playerOneName = 'Player';
  String playerTwoName = 'AI';

  @override
  void initState() {
    super.initState();
    if (widget.isAI && widget.playerSide == 'O') {
      currentPlayer = 'X';
      Future.delayed(Duration(milliseconds: 500), aiMove);
    }
    if (!widget.isAI) {
      playerOneName = 'Player 1';
      playerTwoName = 'Player 2';
    }
  }

  void makeMove(int index) {
    if (board[index] != '' || winner != '') return;

    setState(() {
      board[index] = currentPlayer;

      if (checkWinner(currentPlayer)) {
        winner = '$currentPlayer Wins!!!';
        if (currentPlayer == widget.playerSide) {
          playerScore++;
        } else {
          aiScore++;
        }
      } else if (!board.contains('')) {
        winner = 'Draw';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        if (widget.isAI && currentPlayer != widget.playerSide) {
          Future.delayed(Duration(milliseconds: 500), aiMove);
        }
      }
    });
  }

  void aiMove() {
    if (winner != '') return;

    int bestMove = getBestMove();
    setState(() {
      board[bestMove] = currentPlayer;
      if (checkWinner(currentPlayer)) {
        winner = '$currentPlayer Wins!!!';
        aiScore++;
      } else if (!board.contains('')) {
        winner = 'Draw';
      } else {
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  int getBestMove() {
    // Try to win
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = currentPlayer;
        if (checkWinner(currentPlayer)) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    // Try to block opponent
    String opponent = widget.playerSide;
    for (int i = 0; i < 9; i++) {
      if (board[i] == '') {
        board[i] = opponent;
        if (checkWinner(opponent)) {
          board[i] = '';
          return i;
        }
        board[i] = '';
      }
    }

    // Center
    if (board[4] == '') return 4;

    // Corners
    List<int> corners = [0, 2, 6, 8];
    for (int corner in corners) {
      if (board[corner] == '') return corner;
    }

    // Sides
    List<int> sides = [1, 3, 5, 7];
    for (int side in sides) {
      if (board[side] == '') return side;
    }

    return 0; // fallback
  }

  bool checkWinner(String player) {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var pattern in winPatterns) {
      if (board[pattern[0]] == player &&
          board[pattern[1]] == player &&
          board[pattern[2]] == player) {
        winningTiles = pattern;
        return true;
      }
    }
    return false;
  }

  void resetBoard() {
    setState(() {
      board = List.filled(9, '');
      winningTiles = [];
      winner = '';
      currentPlayer = widget.playerSide == 'X' ? 'X' : 'O';

      if (widget.isAI && currentPlayer != widget.playerSide) {
        Future.delayed(Duration(milliseconds: 500), aiMove);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("TIK TAC TOE", style: titlefont),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 8,
      ),
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(playerOneName, style: normalTextStyle),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lineColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!,
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Text(
                    '$playerScore - $aiScore',
                    style: normalTextStyle,
                  ),
                ),
                Text(playerTwoName, style: normalTextStyle),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            elevation: 10,
            margin: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  bool isWinnerTile = winningTiles.contains(index);
                  return GestureDetector(
                    onTap: () => makeMove(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: index < 6
                              ? const BorderSide(
                                  width: 1.5, color: Colors.green)
                              : BorderSide.none,
                          right: index % 3 != 2
                              ? const BorderSide(width: 1.5, color: Colors.red)
                              : BorderSide.none,
                        ),
                        color: isWinnerTile
                            ? Colors.yellow[100]
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: board[index] == 'X'
                            ? Image.asset('assets/images/cross.png', width: 60)
                            : board[index] == 'O'
                                ? Image.asset('assets/images/circle.png',
                                    width: 60)
                                : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Text(winner, style: normalTextStyle),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetBoard,
            style: ElevatedButton.styleFrom(
              backgroundColor: boxColor,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text('Reset Game', style: buttonTextStyle),
          ),
        ],
      ),
    );
  }
}

//
// Joseph Winters
// Human-controlled paddle
// April 2018
//

import 'dart:math';

import 'ball.dart';
import 'player.dart';

class HumanPlayer extends Player {
  // Constructor.
  HumanPlayer(int canvasHeight, Ball ball, bool isPlayer1)
      : super(canvasHeight, ball, isPlayer1);
}

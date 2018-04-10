//
// Joseph Winters
// Parent class for players/paddles
// April 2018
//

import 'ball.dart';

abstract class Player {
  // TODO: Adjust these numbers as necessary.
  // Height of the paddles.
  static const int PADDLE_HEIGHT = 150;
  // Width of the paddles.
  static const int PADDLE_WIDTH = 25;
  // X-coordinate for the left edge of Player 1's paddle.
  static const int _PLAYER1_LEFT_EDGE = 50;
  // X-coordinate for the right edge of Player 2's paddle.
  static const int _PLAYER2_RIGHT_EDGE = 950;
  // Number of pixels the paddle can move vertically per frame.
  static const int _PADDLE_SPEED = 10;

  // If `true`, this is Player 1, on the left; else Player 2, on the right.
  final bool _isPlayer1;
  // Y-coordinate for the top of the paddle.
  int _top = 175;
  // The ball in play.
  final Ball _ball;
  // The maximum possible y-coordinate.
  final int _canvasHeight;

  // Constructor.
  Player(int canvasHeight, Ball ball)
      : _canvasHeight = canvasHeight,
        _ball = ball;

  // Return a list containing the x- and y-coordinates of the top-left corner.
  List<int> getTopLeftCoordinates();

  // Check collisions with `_ball`.
  void checkCollisionsWithBall() {
    // TODO: Implement.
  }
}

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
  // X-coordinate for the right edge of Player 1's paddle.
  static const int _PLAYER1_RIGHT_EDGE = 50;
  // X-coordinate for the left edge of Player 2's paddle.
  static const int _PLAYER2_LEFT_EDGE = 950;
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
  List<int> getTopLeftCoordinates() {
    int x =
        _isPlayer1 ? (_PLAYER1_RIGHT_EDGE - PADDLE_WIDTH) : _PLAYER2_LEFT_EDGE;
    return [x, _top];
  }

  // Check collisions with `_ball`.
  void checkCollisionsWithBall() {
    // Compute necessary values.
    List<int> ballCoordinates = _ball.getCentreCoordinates();
    int ballX = ballCoordinates[0];
    int ballY = ballCoordinates[1];
    int ballRadius = _ball.RADIUS;
    int paddleBottom = _top + PADDLE_HEIGHT;
    int paddleOneThirdDown = _top + (PADDLE_HEIGHT ~/ 3);
    int paddleTwoThirdsDown = _top + ((PADDLE_HEIGHT ~/ 3) * 2);
    // If the ball is past the paddles, it cannot be stopped.
    if (ballX > _PLAYER2_LEFT_EDGE || ballX < _PLAYER1_RIGHT_EDGE) return;
    // If the ball is in the middle of the board, it cannot bounce.
    if (ballX + _ball.RADIUS < _PLAYER2_LEFT_EDGE ||
        ballX - _ball.RADIUS > _PLAYER1_RIGHT_EDGE) return;
    // Consider the cases where the ball has a chance of bouncing.
    if (_isPlayer1) {
      if (ballY < paddleOneThirdDown && ballY > paddleTwoThirdsDown) {
        // Ball is in middle of paddle; don't change angle.
        _ball.bounceOffPaddle(_PLAYER1_RIGHT_EDGE, 0);
      } else if (ballY <= paddleOneThirdDown) {
        // Check if ball is contacting paddle.
        bool shouldBounce = ballY >= _top ||
            sqrt(pow(ballX - _PLAYER1_RIGHT_EDGE, 2) + pow(ballY - _top, 2)) <
                _ball.RADIUS;
        // Ball is bouncing off top of paddle; angle slightly
        // counter-clockwise.
        if (shouldBounce) _ball.bounceOffPaddle(_PLAYER1_RIGHT_EDGE, -1);
      } else {
        // ballY >= paddleTwoThirdsDown
        // Check if ball is contacting paddle.
        bool shouldBounce = ballY <= paddleBottom ||
            sqrt(pow(ballX - _PLAYER1_RIGHT_EDGE, 2) +
                    pow(ballY - paddleBottom, 2)) <
                _ball.RADIUS;
        // Ball is bouncing off bottom of paddle; angle slightly clockwise.
        if (shouldBounce) _ball.bounceOffPaddle(_PLAYER1_RIGHT_EDGE, 1);
      }
    } else {
      if (ballY < paddleOneThirdDown && ballY > paddleTwoThirdsDown) {
        // Ball is in middle of paddle; don't change angle.
        _ball.bounceOffPaddle(_PLAYER2_LEFT_EDGE, 0);
      } else if (ballY <= paddleOneThirdDown) {
        // Check if ball is contacting paddle.
        bool shouldBounce = ballY >= _top ||
            sqrt(pow(ballX - _PLAYER2_LEFT_EDGE, 2) + pow(ballY - _top, 2)) <
                _ball.RADIUS;
        // Ball is bouncing off top of paddle; angle slightly clockwise.
        if (shouldBounce) _ball.bounceOffPaddle(_PLAYER2_LEFT_EDGE, 1);
      } else {
        // ballY >= paddleTwoThirdsDown
        // Check if ball is contacting paddle.
        bool shouldBounce = ballY <= paddleBottom ||
            sqrt(pow(ballX - _PLAYER2_LEFT_EDGE, 2) +
                    pow(ballY - paddleBottom, 2)) <
                _ball.RADIUS;
        // Ball is bouncing off bottom of paddle; angle slightly
        // counter-clockwise.
        if (shouldBounce) _ball.bounceOffPaddle(_PLAYER2_LEFT_EDGE, -1);
      }
    }
  }
}

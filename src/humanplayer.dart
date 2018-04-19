//
// Joseph Winters
// Human-controlled paddle
// April 2018
//

import 'ball.dart';
import 'player.dart';

class HumanPlayer extends Player {
  // Constructor.
  HumanPlayer(int canvasHeight, Ball ball) : super(canvasHeight, ball);

  // Move the paddle up `_PADDLE_SPEED` pixels.
  void moveUp() {
    top -= _PADDLE_SPEED;
    top = max(top, 0);
  }

  // Move the paddle down `_PADDLE_SPEED` pixels.
  void moveDown() {
    top += _PADDLE_SPEED;
    top = min(top, canvasHeight - Player.PADDLE_HEIGHT);
  }
}

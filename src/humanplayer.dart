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

  // Move the paddle up `PADDLE_SPEED` pixels.
  void moveUp() {
    top -= Player.PADDLE_SPEED;
    top = max(top, 0);
  }

  // Move the paddle down `PADDLE_SPEED` pixels.
  void moveDown() {
    top += Player.PADDLE_SPEED;
    top = min(top, canvasHeight - Player.PADDLE_HEIGHT);
  }
}

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
    _top -= _PADDLE_SPEED;
    _top = max(_top, 0);
  }

  // Move the paddle down `_PADDLE_SPEED` pixels.
  void moveDown() {
    _top += _PADDLE_SPEED;
    _top = min(_top, _canvasHeight - Player.PADDLE_HEIGHT);
  }
}

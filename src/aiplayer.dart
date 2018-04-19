//
// Joseph Winters
// AI-controlled paddle
// April 2018
//

import 'ball.dart';
import 'player.dart';

class AIPlayer extends Player {
  // Constructor.
  AIPlayer(int canvasHeight, Ball ball) : super(canvasHeight, ball);
  // TODO: Remove this.
  int _currentDirection = 1;

  // Determine the best direction to move in and move.
  @override
  void move() {
    // TODO: Implement actual functionality.
    top += _currentDirection * _PADDLE_SPEED;
    if (top < 0) {
      top = 0;
      _currentDirection *= -1;
    } else if (top + Player.PADDLE_HEIGHT > canvasHeight) {
      top = canvasHeight - Player.PADDLE_HEIGHT;
      _currentDirection *= -1;
    }
  }
}

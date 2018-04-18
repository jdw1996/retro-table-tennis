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
    _top += _currentDirection * _PADDLE_SPEED;
    if (_top < 0) {
      _top = 0;
      _currentDirection *= -1;
    } else if (_top + PADDLE_HEIGHT > _canvasHeight) {
      _top = _canvasHeight - PADDLE_HEIGHT;
      _currentDirection *= -1;
    }
  }
}

//
// Joseph Winters
// AI-controlled paddle
// April 2018
//

import 'ball.dart';
import 'player.dart';

class AIPlayer extends Player {
  // Constructor.
  AIPlayer(int canvasHeight, Ball ball, bool isPlayer1)
      : super(canvasHeight, ball, isPlayer1);

  // Determine the best direction to move in and move.
  @override
  void move() {
    int ballY = ball.getCentreCoordinates()[1];
    // TODO: Adjust "sweet spot" as necessary.
    if (ballY <= top + Player.PADDLE_HEIGHT / 3) {
      moveUp();
    } else if (ballY >= top + (2 * Player.PADDLE_HEIGHT) / 3) {
      moveDown();
    }
  }
}

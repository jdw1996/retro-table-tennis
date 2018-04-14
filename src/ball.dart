//
// Joseph Winters
// Ball
// April 2018
//

import 'dart:math';

enum Angle {
  STEEP, MIDDLE, STRAIGHT
}

class Ball {
  // TODO: Adjust these numbers as necessary.
  // Radius of the ball.
  static const int RADIUS = 50;

  // X-coordinate for the centre of the ball.
  int _x = 500;
  // Y-coordinate for the centre of the ball.
  int _y = 250;
  // Angle at which the ball is currently travelling.
  Angle _currentAngle;
  // Number of pixel-widths to move diagonally each iteration.
  int _speed = 10;
  // Should be `1` if the ball is moving down; `0` if horizontal; else `-1`.
  int _verticalFactor;
  // Should be `1` if the ball is moving right; else `-1`.
  int _horizontalFactor;
  // Random number generator.
  Random random;

  // Constructor.
  Ball() {
    random = new Random();
    _currentAngle = Angle.values[random.nextInt(Angle.values.length)];
    if (_currentAngle == Angle.STRAIGHT) {
      _verticalFactor = 0;
    } else {
      _verticalFactor = [-1, 1][random.nextInt(2)];
    }
  }

  // Return a list containing the x- and y-coordinates of the centre.
  List<int> getCentreCoordinates() {
    return [_x, _y];
  }

  // Move the ball.
  void move() {
    // TODO: Implement.
  }
}

//
// Joseph Winters
// Ball
// April 2018
//

import 'dart:math';

enum Angle { STEEP, MIDDLE, STRAIGHT }

class Ball {
  // Radius of the ball.
  static const int RADIUS = 30;
  // Initial x-coordinate for the centre of the ball.
  static const int _INITIAL_X = 500;
  // Initial y-coordinate for the centre of the ball.
  static const int _INITIAL_Y = 250;
  // Initial number of pixel-widths to move diagonally each iteration.
  static const int _INITIAL_SPEED = 15;

  // The maximum possible y-coordinate.
  final int _canvasHeight;
  // X-coordinate for the centre of the ball.
  int _x = _INITIAL_X;
  // Y-coordinate for the centre of the ball.
  int _y = _INITIAL_Y;
  // Angle at which the ball is currently travelling.
  Angle _currentAngle;
  // Number of pixel-widths to move diagonally each iteration.
  int _speed = _INITIAL_SPEED;
  // Should be `1` if the ball is moving down; `0` if horizontal; else `-1`.
  int _verticalFactor;
  // Should be `1` if the ball is moving right; else `-1`.
  int _horizontalFactor;
  // Random number generator.
  Random random;

  // Constructor.
  Ball(int canvasHeight) : _canvasHeight = canvasHeight {
    random = new Random();
    _randomizeAngle();
    _horizontalFactor = -1;
  }

  // Change movement to a random angle.
  void _randomizeAngle() {
    _currentAngle = Angle.values[random.nextInt(Angle.values.length)];
    if (_currentAngle == Angle.STRAIGHT) {
      _verticalFactor = 0;
    } else {
      _verticalFactor = [-1, 1][random.nextInt(2)];
    }
    _horizontalFactor = [-1, 1][random.nextInt(2)];
  }

  // If `rotation` is -1, rotate counter-clockwise; if 0, no rotation; if 1,
  // rotate clockwise.
  void _rotateAngle(int rotation) {
    if (rotation == 0) {
      // No rotation necessary.
      return;
    } else if (rotation == -1) {
      // Rotate counter-clockwise.
      if (_verticalFactor == 0) {
        _verticalFactor = -_horizontalFactor;
        _currentAngle = Angle.MIDDLE;
      } else if (_verticalFactor == -1) {
        if (_horizontalFactor == -1) {
          // The ball is moving northwest.
          if (_currentAngle == Angle.STEEP) {
            _currentAngle == Angle.MIDDLE;
          } else {
            _currentAngle = Angle.STRAIGHT;
            _verticalFactor = 0;
          }
        } else {
          // The ball is moving northeast.
          _currentAngle = Angle.STEEP;
        }
      } else {
        if (_horizontalFactor == -1) {
          // The ball is moving southwest.
          _currentAngle = Angle.STEEP;
        } else {
          // The ball is moving southeast.
          if (_currentAngle == Angle.STEEP) {
            _currentAngle = Angle.MIDDLE;
          } else {
            _currentAngle = Angle.STRAIGHT;
            _verticalFactor = 0;
          }
        }
      }
    } else {
      // Rotate clockwise.
      if (_verticalFactor == 0) {
        _verticalFactor = _horizontalFactor;
        _currentAngle = Angle.MIDDLE;
      } else if (_verticalFactor == -1) {
        if (_horizontalFactor == -1) {
          // The ball is moving northwest.
          _currentAngle = Angle.STEEP;
        } else {
          // The ball is moving northeast.
          if (_currentAngle == Angle.STEEP) {
            _currentAngle = Angle.MIDDLE;
          } else {
            _currentAngle = Angle.STRAIGHT;
            _verticalFactor = 0;
          }
        }
      } else {
        if (_horizontalFactor == -1) {
          // The ball is moving southwest.
          if (_currentAngle == Angle.STEEP) {
            _currentAngle = Angle.MIDDLE;
          } else {
            _currentAngle = Angle.STRAIGHT;
            _verticalFactor = 0;
          }
        } else {
          // The ball is moving southeast.
          _currentAngle = Angle.STEEP;
        }
      }
    }
  }

  // Increment the speed of the ball, limiting speed to `RADIUS`.
  void _incrementSpeed() {
    if (_speed < RADIUS) _speed++;
  }

  // Return a list containing the x- and y-coordinates of the centre.
  List<int> getCentreCoordinates() {
    return [_x, _y];
  }

  // Move the ball.
  void move() {
    if (_currentAngle == Angle.STRAIGHT) {
      _x += _speed * _horizontalFactor;
      return;
    }

    num angle = _currentAngle == Angle.STEEP ? PI / 4 : PI / 8;
    _x += (cos(angle) * _speed).round() * _horizontalFactor;
    _y += (sin(angle) * _speed).round() * _verticalFactor;
    if (_y + RADIUS > _canvasHeight) {
      // Reflect the ball back over the bottom of the canvas.
      _y = (2 * _canvasHeight) - _y - (2 * RADIUS);
      _verticalFactor = -1;
    } else if (_y - RADIUS < 0) {
      // Reflect the ball back over the top of the canvas.
      _y = (2 * RADIUS) - _y;
      _verticalFactor = 1;
    }
  }

  // Set the ball to move left and change angle if necessary.  If `rotation` is
  // -1, rotate counter-clockwise; if 0, no rotation; if 1, rotate clockwise.
  void bounceLeft(int paddleX, int rotation) {
    _x = (2 * paddleX) - _x - (2 * RADIUS);
    _horizontalFactor = -1;
    _rotateAngle(rotation);
    _incrementSpeed();
  }

  // Set the ball to move right and change angle if necessary.  If `rotation`
  // is -1, rotate counter-clockwise; if 0, no rotation; if 1, rotate
  // clockwise.
  void bounceRight(int paddleX, int rotation) {
    _x = (2 * paddleX) - _x + (2 * RADIUS);
    _horizontalFactor = 1;
    _rotateAngle(rotation);
    _incrementSpeed();
  }

  // Return the ball to the centre of the screen.
  void reset() {
    _x = _INITIAL_X;
    _y = _INITIAL_Y;
    _speed = _INITIAL_SPEED;
    _randomizeAngle();
  }
}

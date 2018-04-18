//
// Joseph Winters
// Display game
// April 2018
//

import 'dart:html';
import 'dart:math';

import 'input.dart';
import 'score.dart';
import 'screen.dart';
import 'settings.dart';
import 'player.dart';
import 'aiplayer.dart';
import 'humanplayer.dart';

class GameScreen extends Screen {
  // If `true`, it's time to transition to the next screen.
  bool _isDone = false;
  // For getting keyboard input.
  final Keyboard _keyboard;
  // Current score of the game.
  final Score _currentScore;
  // HTML element to hold current score of the game.
  Element scoreElement;
  // Players of the game.
  Player _player1;
  Player _player2AI;
  Player _player2Human;
  Player _player2;
  // Ball for the game.
  final Ball _ball;
  // Maximum score to play to.
  int _playToScore = 7;

  // Constructor.
  GameScreen(CanvasElement canvas, Keyboard keyboard)
      : super(canvas),
        _keyboard = keyboard {
    _currentScore = new Score();
    _ball = new Ball();
    // Player 1 is always human.
    _player1 = new HumanPlayer(_canvas.height);
    // Player 2 may be either human or AI.
    _player2AI = new AIPlayer(_canvas.height, _ball);
    _player2Human = new HumanPlayer(_canvas.height);
    // Let Player 2 be AI by default.
    _player2 = _player2AI;
  }

  // Update the score displayed on the screen.
  void _updateDisplayedScore() {
    scoreElement.text = "${_currentScore.score1}-${_currentScore.score2}";
  }

  // Add a point to Player 1's total.
  void _player1Score() {
    _currentScore.score1 += 1;
    _updateDisplayedScore();
    _ball.reset();
    if (_currentScore.score1 == _playToScore) _isDone = true;
  }

  // Add a point to Player 2's total.
  void _player2Score() {
    _currentScore.score2 += 1;
    _updateDisplayedScore();
    _ball.reset();
    if (_currentScore.score2 == _playToScore) _isDone = true;
  }

  // Perform logical updates.
  void _update() {
    // Move the ball.
    _ball.move();
    // Move Player 1.
    if (keyboard.isPressed(KeyCode.W)) {
      _player1.moveUp();
    } else if (keyboard.isPressed(KeyCode.S)) {
      _player1.moveDown();
    }
    // Move Player 2.
    if (identical(_player2, _player2Human)) {
      if (keyboard.isPressed(KeyCode.UP)) {
        _player2Human.moveUp();
      } else if (keyboard.isPressed(KeyCode.DOWN)) {
        _player2Human.moveDown();
      }
    } else {
      _player2AI.move();
    }
    // Check if a point has been scored.
    int ballX = _ball.getCentreCoordinates()[0];
    if (ballX + _ball.RADIUS < 0) {
      _player2Score();
    } else if (ballX - _ball.RADIUS > _canvas.width) {
      _player1Score();
    }
  }

  // Display the updated state on the canvas.
  void _display() {
    // Display Player 1.
    List<int> player1Coordinates = _player1.getTopLeftCoordinates();
    _canvasContext
      ..fillStyle = "red"
      ..fillRect(player1Coordinates[0], player1Coordinates[1],
          _player1.PADDLE_WIDTH, _player1.PADDLE_HEIGHT);
    // Display Player 2.
    List<int> player2Coordinates = _player2.getTopLeftCoordinates();
    _canvasContext
      ..fillStyle = "blue"
      ..fillRect(player2Coordinates[0], player2Coordinates[1],
          _player2.PADDLE_WIDTH, _player2.PADDLE_HEIGHT);
    // Display the ball.
    List<int> ballCoordinates = _ball.getCentreCoordinates();
    _canvasContext
      ..fillStyle = "white"
      ..beginPath()
      ..arc(ballCoordinates[0], ballCoordinates[1], _ball.RADIUS, 0, 2 * PI)
      ..fill();
  }

  // Execute any necessary game actions and draw the new state on the canvas.
  @override
  void updateAndDraw() {
    _update();
    _draw();
  }

  // Return `true` if it's time to transition to the next screen; else `false`.
  @override
  bool isDone() => _isDone;

  // Return the `Screen` to its original state.
  @override
  void reset() {
    _isDone = false;
    _currentScore.reset();
  }

  // Use `newSettings` as the settings for the game.
  void setSettings(Settings newSettings) {
    _player2 = newSettings.isTwoPlayer ? _player2Human : _player2AI;
    _playToScore = newSettings.playToScore;
  }

  // Return the current score of the game.
  Score getScore() => _currentScore;
}

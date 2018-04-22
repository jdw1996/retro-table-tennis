//
// Joseph Winters
// Display game
// April 2018
//

import 'dart:html';
import 'dart:math';

import 'ball.dart';
import 'input.dart';
import 'score.dart';
import 'display.dart';
import 'settings.dart';
import 'player.dart';
import 'aiplayer.dart';
import 'humanplayer.dart';

class GameDisplay extends Display {
  // If `true`, it's time to transition to the next display.
  bool _isDone = false;
  // For getting keyboard input.
  final Keyboard _keyboard;
  // Current score of the game.
  Score _currentScore;
  // HTML element to hold current score of the game.
  Element scoreElement;
  // Players of the game.
  HumanPlayer _player1;
  AIPlayer _player2AI;
  HumanPlayer _player2Human;
  Player _player2;
  // Ball for the game.
  Ball _ball;
  // Maximum score to play to.
  int _playToScore = 7;

  // Constructor.
  GameDisplay(CanvasElement canvas, Keyboard keyboard)
      : super(canvas),
        _keyboard = keyboard {
    _currentScore = new Score(0, 0);
    _ball = new Ball(canvas.height);
    // Player 1 is always human.
    _player1 = new HumanPlayer(canvas.height, _ball, true);
    // Player 2 may be either human or AI.
    _player2AI = new AIPlayer(canvas.height, _ball, false);
    _player2Human = new HumanPlayer(canvas.height, _ball, false);
    // Let Player 2 be AI by default.
    _player2 = _player2AI;
  }

  // Update the score displayed on the display.
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
    if (_keyboard.isPressed(KeyCode.W)) {
      _player1.moveUp();
    } else if (_keyboard.isPressed(KeyCode.S)) {
      _player1.moveDown();
    }
    // Move Player 2.
    if (identical(_player2, _player2Human)) {
      if (_keyboard.isPressed(KeyCode.UP)) {
        _player2Human.moveUp();
      } else if (_keyboard.isPressed(KeyCode.DOWN)) {
        _player2Human.moveDown();
      }
    } else {
      _player2AI.move();
    }
    // Check if a point has been scored.
    int ballX = _ball.getCentreCoordinates()[0];
    if (ballX + Ball.RADIUS < 0) {
      _player2Score();
      _ball.reset();
    } else if (ballX - Ball.RADIUS > canvas.width) {
      _player1Score();
      _ball.reset();
    }
  }

  // Display the updated state on the canvas.
  void _display() {
    clearDisplay();
    // Display Player 1.
    List<int> player1Coordinates = _player1.getTopLeftCoordinates();
    canvasContext
      ..fillStyle = "red"
      ..fillRect(player1Coordinates[0], player1Coordinates[1],
          Player.PADDLE_WIDTH, Player.PADDLE_HEIGHT);
    // Display Player 2.
    List<int> player2Coordinates = _player2.getTopLeftCoordinates();
    canvasContext
      ..fillStyle = "blue"
      ..fillRect(player2Coordinates[0], player2Coordinates[1],
          Player.PADDLE_WIDTH, Player.PADDLE_HEIGHT);
    // Display the ball.
    List<int> ballCoordinates = _ball.getCentreCoordinates();
    canvasContext
      ..fillStyle = "white"
      ..beginPath()
      ..arc(ballCoordinates[0], ballCoordinates[1], Ball.RADIUS, 0, 2 * PI)
      ..fill();
  }

  // Execute any necessary game actions and draw the new state on the canvas.
  @override
  void updateAndDraw() {
    _update();
    _display();
  }

  // Return `true` if it's time to transition to the next display; else
  // `false`.
  @override
  bool isDone() => _isDone;

  // Return the `Display` to its original state.
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

//
// Joseph Winters
// Display game
// April 2018
//

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
  // Players of the game.
  // TODO: Define `Player`, `HumanPlayer`, and `AIPlayer`.
  Player _player1;
  Player _player2AI;
  Player _player2Human;
  Player _player2;
  // Ball for the game.
  // TODO: Define `Ball`.
  final Ball _ball;

  // Constructor.
  GameScreen(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse {
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

  // Perform logical updates.
  void _update() {
    // TODO: Implement.
  }

  // Display the updated state on the canvas.
  void _display() {
    // TODO: Implement.
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
    // TODO: Finish implementing.
  }

  // Use `newSettings` as the settings for the game.
  void setSettings(Settings newSettings) {
    _currentSettings = newSettings;
    // TODO: Finish implementing.
  }

  // Return the current score of the game.
  Score getScore() => _currentScore;
}
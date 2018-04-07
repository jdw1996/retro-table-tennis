//
// Joseph Winters
// Display end-of-game screen
// April 2018
//

import 'input.dart';
import 'screen.dart';

class EndScreen extends Screen {
  // If `true`, it's time to transition to the next screen.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;
  // Score of the game just ended.
  Score _latestScore;
  // If `true`, there were two human players in the game.
  bool _isTwoPlayer;
  // If `true`, settings must be changed before replaying.
  bool _mustChangeSettings;

  // Constructor.
  EndScreen(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

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
  }

  // Set the score of the game just ended.
  void setScore(score, isTwoPlayer) {
    _latestScore = score;
    _isTwoPlayer = isTwoPlayer;
  }

  // Return `true` if settings must be changed before replaying; else `false`.
  bool mustChangeSettings() => _mustChangeSettings;
}

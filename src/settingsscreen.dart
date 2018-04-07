//
// Joseph Winters
// Display settings selection
// March 2018
//

import 'input.dart';
import 'screen.dart';

class SettingsScreen extends Screen {
  // If `true`, it's time to transition to the next screen.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;

  // Constructor.
  SettingsScreen(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

  // Perform logical updates.
  void _update() {
    // TODO: Implement.
  }

  // Display the updated display on the canvas.
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
}

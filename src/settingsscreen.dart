//
// Joseph Winters
// Display settings selection
// March 2018
//

import 'input.dart';
import 'screen.dart';
import 'settings.dart';

class SettingsScreen extends Screen {
  // If `true`, it's time to transition to the next screen.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;
  // Current settings.
  Settings _currentSettings;

  // Constructor.
  SettingsScreen(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

  // Perform logical updates.
  void _update() {
    // TODO: Implement actual functionality.
    if (_mouse.hasNewClick()) _isDone = true;
  }

  // Display the updated state on the canvas.
  void _display() {
    _clearScreen();
    // TODO: Implement actual functionality.
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

  // Return the current settings.
  Settings getSettings() => _currentSettings;
}

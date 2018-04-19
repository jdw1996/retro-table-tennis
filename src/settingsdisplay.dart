//
// Joseph Winters
// Display settings selection
// March 2018
//

import 'dart:html';

import 'input.dart';
import 'display.dart';
import 'settings.dart';

class SettingsDisplay extends Display {
  // If `true`, it's time to transition to the next display.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;
  // Current settings.
  Settings _currentSettings;

  // Constructor.
  SettingsDisplay(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

  // Perform logical updates.
  void _update() {
    // TODO: Implement actual functionality.
    if (_mouse.hasNewClick()) _isDone = true;
  }

  // Display the updated state on the canvas.
  void _display() {
    clearDisplay();
    // TODO: Implement actual functionality.
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
  }

  // Return the current settings.
  Settings getSettings() => _currentSettings;
}

//
// Joseph Winters
// Main execution
// July 2017
//

import 'dart:html';

import 'ball.dart';
import 'input.dart';
import 'score.dart';
import 'settings.dart';
import 'display.dart';
import 'settingsdisplay.dart';
import 'gamedisplay.dart';
import 'enddisplay.dart';

class Main {
  // Minimum time in milliseconds between game and screen updates.
  static const num _GAME_UPDATE_INTERVAL = 50;

  // Canvas to draw the game on.
  CanvasElement _canvas;
  CanvasRenderingContext2D _canvasContext;

  // Objects to handle mouse and keyboard input.
  Keyboard _keyboard;
  Mouse _mouse;

  // Objects containing logic for different display modes.
  SettingsDisplay _settingsDisplay;
  GameDisplay _gameDisplay;
  EndDisplay _endDisplay;

  // Reference to whichever `Display` is currently being displayed.
  Display _currentDisplay;

  // Score of the most recently finished game.
  Score _latestScore;

  // Current game settings.
  Settings _currentSettings;

  // Last time the screen and game state were updated.
  num _lastUpdateTime = 0;

  // Constructor.
  Main() {
    _canvas = querySelector("#mycanvas");
    _canvasContext = _canvas.getContext("2d");

    _keyboard = new Keyboard();
    _mouse = new Mouse();

    _settingsDisplay = new SettingsDisplay(_canvas, _mouse);
    _gameDisplay = new GameDisplay(_canvas, _keyboard);
    _endDisplay = new EndDisplay(_canvas, _mouse);

    _currentDisplay = _settingsDisplay;
  }

  // Clear the canvas.
  void _clear() {
    _canvasContext
      ..fillStyle = "black"
      ..fillRect(0, 0, _canvas.width, _canvas.height);
  }

  // Check if `_currentDisplay` is done executing and transition if so.
  void _checkAndTransitionDisplay() {
    if (!_currentDisplay.isDone()) return;

    Display nextDisplay;
    if (identical(_currentDisplay, _settingsDisplay)) {
      nextDisplay = _gameDisplay;
      _currentSettings = _settingsDisplay.getSettings();
      _gameDisplay.setSettings(_currentSettings);
    } else if (identical(_currentDisplay, _gameDisplay)) {
      nextDisplay = _endDisplay;
      _latestScore = _gameDisplay.getScore();
      _endDisplay.setScore(_latestScore, _currentSettings.isTwoPlayer);
    } else {
      // Must have: identical(_currentDisplay, _endDisplay)
      nextDisplay =
          _endDisplay.mustChangeSettings() ? _settingsDisplay : _gameDisplay;
    }

    _currentDisplay.reset();
    _currentDisplay = nextDisplay;
  }

  // Advance all game mechanics and display the game.
  void update(num currentTime) {
    final num delta = currentTime - _lastUpdateTime;

    if (delta > _GAME_UPDATE_INTERVAL) {
      _lastUpdateTime = currentTime;
      _clear();
      _currentDisplay.updateAndDraw();
      _checkAndTransitionDisplay();
    }

    // Continue the game loop.
    run();
  }

  // Begin the game.
  void run() {
    window.animationFrame.then(update);
  }
}

void main() {
  new Main()..run();
}

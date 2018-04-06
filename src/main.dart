//
// Joseph Winters
// Main execution
// July 2017
//

import 'input.dart';
import 'score.dart';
import 'settings.dart';
import 'screen.dart';

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
  SettingsScreen _settingsScreen;
  GameScreen _gameScreen;
  EndScreen _endScreen;

  // Reference to whichever `Screen` is currently being displayed.
  Screen _currentScreen;

  // Score of the most recently finished game.
  Score _latestScore;

  // Current game settings.
  Settings _currentSettings;

  // Last time the screen and game state were updated.
  num _lastUpdateTime = 0;

  // Constructor.
  Main() {
    _canvas = querySelector("#mycanvas")..focus();

    _keyboard = new Keyboard();
    _mouse = new Mouse();

    // TODO: Define `SettingsScreen`.
    _settingsScreen = new SettingsScreen(_canvas, _mouse);
    // TODO: Define `GameScreen`.
    _gameScreen = new GameScreen(_canvas, _keyboard);
    // TODO: Define `EndScreen`.
    _endScreen = new EndScreen(_canvas, _mouse);

    _currentScreen = _settingsScreen;
  }

  // Clear the canvas.
  void _clear() {
    _canvasContext
      ..fillStyle = "black"
      ..fillRect(0, 0, _canvas.width, _canvas.height);
  }

  // Check if `_currentScreen` is done executing and transition if so.
  void _checkAndTransitionScreen() {
    if (!_currentScreen.isDone()) return;

    Screen nextScreen;
    if (identical(_currentScreen, _settingsScreen)) {
      nextScreen = _gameScreen;
      _currentSettings = _settingsScreen.getSettings();
      _gameScreen.setSettings(_currentSettings);
    } else if (identical(_currentScreen, _gameScreen)) {
      nextScreen = _endScreen;
      _latestScore = _gameScreen.getScore();
      _endScreen.setScore(_latestScore, _currentSettings.isTwoPlayer);
    } else {
      // Must have: identical(_currentScreen, _endScreen)
      nextScreen =
          _endScreen.mustChangeSettings() ? _settingsScreen : _gameScreen;
    }

    _currentScreen.reset();
    _currentScreen = nextScreen;
  }

  // Advance all game mechanics and display the game.
  void update(num currentTime) {
    final num delta = currentTime - _lastUpdateTime;

    if (delta > _GAME_UPDATE_INTERVAL) {
      _lastUpdateTime = currentTime;
      _clear();
      _currentScreen.updateAndDraw();
      _checkAndTransitionScreen();
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

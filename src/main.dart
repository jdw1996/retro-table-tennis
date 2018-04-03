//
// Joseph Winters
// Main execution
// July 2017
//

import 'score.dart';
import 'settings.dart';
import 'screen.dart';

class Main {
  // Minimum time in milliseconds between game and screen updates.
  static const num _GAME_UPDATE_INTERVAL = 50;

  // Canvas to draw the game on.
  CanvasElement _canvas;
  CanvasRenderingContext2D _canvasContext;

  // Objects containing logic for different display modes.
  IntroScreen _introScreen;
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
    canvas = querySelector("#mycanvas")..focus();

    // TODO: Define `IntroScreen`.
    _introScreen = new IntroScreen(_canvas);
    // TODO: Define `SettingsScreen`.
    _settingsScreen = new SettingsScreen(_canvas);
    // TODO: Define `GameScreen`.
    _gameScreen = new GameScreen(_canvas);
    // TODO: Define `EndScreen`.
    _endScreen = new EndScreen(_canvas);

    _currentScreen = _introScreen;
  }

  // Clear the canvas.
  void clear() {
    _canvasContext
      ..fillStyle = "black"
      ..fillRect(0, 0, _canvas.width, _canvas.height);
  }

  // Advance all game mechanics and display the game.
  void update(num currentTime) {
    final num delta = currentTime - _lastUpdateTime;

    if (delta > _GAME_UPDATE_INTERVAL) {
      _lastUpdateTime = currentTime;
      _clear();
      _currentScreen.updateAndDraw();
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

//
// Joseph Winters
// Display settings selection
// March 2018
//

import 'dart:html';
import 'dart:math';

import 'input.dart';
import 'display.dart';
import 'settings.dart';

class SettingsDisplay extends Display {
  // Text for setting number of players.
  static const String NUM_PLAYERS_TEXT = "Number of players:";
  // Text for setting maximum score.
  static const String SCORE_TO_WIN_TEXT = "Score needed to win:";
  // Text for starting the game.
  static const String START_GAME_TEXT = "START";

  // Width in pixels of the buttons.
  static const int BUTTON_WIDTH = 70;
  // Height in pixels of the buttons.
  static const int BUTTON_HEIGHT = 70;
  // Width in pixels of the start button.
  static const int START_BUTTON_WIDTH = 200;
  // Height in pixels of the start button.
  static const int START_BUTTON_HEIGHT = 100;

  // Coordinates of buttons.
  static const int NUM_PLAYERS_DECREASE_X = 600;
  static const int NUM_PLAYERS_DECREASE_Y = 40;
  static const int NUM_PLAYERS_INCREASE_X = 850;
  static const int NUM_PLAYERS_INCREASE_Y = NUM_PLAYERS_DECREASE_Y;
  static const int POINTS_TO_WIN_DECREASE_X = NUM_PLAYERS_DECREASE_X;
  static const int POINTS_TO_WIN_DECREASE_Y = 200;
  static const int POINTS_TO_WIN_INCREASE_X = NUM_PLAYERS_INCREASE_X;
  static const int POINTS_TO_WIN_INCREASE_Y = POINTS_TO_WIN_DECREASE_Y;
  static const int START_BUTTON_X = 400;
  static const int START_BUTTON_Y = 350;

  // If `true`, it's time to transition to the next display.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;
  // Current settings.
  Settings _currentSettings;

  // Constructor.
  SettingsDisplay(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse {
    _currentSettings = new Settings(false, 7);
  }

  // Draw a button at the given coordinates, with the given text.
  void _drawButton(int x, int y, String text) {
    canvasContext
      ..fillStyle = Display.BUTTON_COLOUR
      ..fillRect(x, y, BUTTON_WIDTH, BUTTON_HEIGHT)
      ..font = Display.MONO_FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText(text, (x + 20), (y + BUTTON_HEIGHT - 20));
  }

  // Perform logical updates.
  void _update() {
    if (!_mouse.hasNewClick()) return;
    List<int> mouseCoordinates = _mouse.getClickCoordinates();
    int mouseX = mouseCoordinates[0];
    int mouseY = mouseCoordinates[1];
    if ((mouseX >= NUM_PLAYERS_DECREASE_X) &&
        (mouseX <= NUM_PLAYERS_DECREASE_X + BUTTON_WIDTH) &&
        (mouseY >= NUM_PLAYERS_DECREASE_Y) &&
        (mouseY <= NUM_PLAYERS_DECREASE_Y + BUTTON_HEIGHT)) {
      _currentSettings.isTwoPlayer = false;
    } else if ((mouseX >= NUM_PLAYERS_INCREASE_X) &&
        (mouseX <= NUM_PLAYERS_INCREASE_X + BUTTON_WIDTH) &&
        (mouseY >= NUM_PLAYERS_INCREASE_Y) &&
        (mouseY <= NUM_PLAYERS_INCREASE_Y + BUTTON_HEIGHT)) {
      _currentSettings.isTwoPlayer = true;
    } else if ((mouseX >= POINTS_TO_WIN_DECREASE_X) &&
        (mouseX <= POINTS_TO_WIN_DECREASE_X + BUTTON_WIDTH) &&
        (mouseY >= POINTS_TO_WIN_DECREASE_Y) &&
        (mouseY <= POINTS_TO_WIN_DECREASE_Y + BUTTON_HEIGHT)) {
      _currentSettings.playToScore = max(1, _currentSettings.playToScore - 1);
    } else if ((mouseX >= POINTS_TO_WIN_INCREASE_X) &&
        (mouseX <= POINTS_TO_WIN_INCREASE_X + BUTTON_WIDTH) &&
        (mouseY >= POINTS_TO_WIN_INCREASE_Y) &&
        (mouseY <= POINTS_TO_WIN_INCREASE_Y + BUTTON_HEIGHT)) {
      _currentSettings.playToScore = min(99, _currentSettings.playToScore + 1);
    } else if ((mouseX >= START_BUTTON_X) &&
        (mouseX <= START_BUTTON_X + START_BUTTON_WIDTH) &&
        (mouseY >= START_BUTTON_Y) &&
        (mouseY <= START_BUTTON_Y + START_BUTTON_HEIGHT)) {
      _isDone = true;
    }
  }

  // Display the updated state on the canvas.
  void _display() {
    clearDisplay();
    // Display names of settings.
    canvasContext
      ..font = Display.FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText(NUM_PLAYERS_TEXT, 50, 90)
      ..fillText(SCORE_TO_WIN_TEXT, 50, 250);
    // Display buttons for changing number of players.
    _drawButton(NUM_PLAYERS_DECREASE_X, NUM_PLAYERS_DECREASE_Y, "-");
    _drawButton(NUM_PLAYERS_INCREASE_X, NUM_PLAYERS_INCREASE_Y, "+");
    canvasContext
      ..font = Display.MONO_FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText("${_currentSettings.isTwoPlayer ? 2 : 1}", 750, 90);
    // Display buttons for changing number of points to win.
    _drawButton(POINTS_TO_WIN_DECREASE_X, POINTS_TO_WIN_DECREASE_Y, "-");
    _drawButton(POINTS_TO_WIN_INCREASE_X, POINTS_TO_WIN_INCREASE_Y, "+");
    canvasContext
      ..font = Display.MONO_FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText("${_currentSettings.playToScore}".padLeft(2, "0"), 740, 250);
    // Display the game start button.
    canvasContext
      ..fillStyle = Display.BUTTON_COLOUR
      ..fillRect(START_BUTTON_X, START_BUTTON_Y, START_BUTTON_WIDTH,
          START_BUTTON_HEIGHT)
      ..font = Display.MONO_FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText(START_GAME_TEXT, 430, 420);
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

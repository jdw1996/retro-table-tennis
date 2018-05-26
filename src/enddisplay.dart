//
// Joseph Winters
// Display end-of-game screen
// April 2018
//

import 'dart:html';

import 'input.dart';
import 'display.dart';
import 'score.dart';

class EndDisplay extends Display {
  // Messages to display about the winner.
  static const String PLAYER1_VICTORY_MESSAGE = "Player 1 has won!";
  static const String PLAYER2_VICTORY_MESSAGE = "Player 2 has won!";
  static const String HUMAN_VICTORY_MESSAGE = "You won the game!";
  static const String AI_VICTORY_MESSAGE = "You lost the game…";

  // Text for the button to play again.
  static const String PLAY_AGAIN_TEXT = "Play Again";
  // Text for the button to change settings.
  static const String CHANGE_SETTINGS_TEXT = "Change Settings";

  // Dimensions of buttons.
  static const int PLAY_AGAIN_BUTTON_WIDTH = 270;
  static const int PLAY_AGAIN_BUTTON_HEIGHT = 80;
  static const int CHANGE_SETTINGS_BUTTON_WIDTH = 390;
  static const int CHANGE_SETTINGS_BUTTON_HEIGHT = 80;

  // Coordinates of buttons.
  static const int PLAY_AGAIN_BUTTON_X = 50;
  static const int PLAY_AGAIN_BUTTON_Y = 350;
  static const int CHANGE_SETTINGS_BUTTON_X = 560;
  static const int CHANGE_SETTINGS_BUTTON_Y = PLAY_AGAIN_BUTTON_Y;

  // If `true`, it's time to transition to the next display.
  bool _isDone = false;
  // For getting clicks.
  final Mouse _mouse;
  // Score of the game just ended.
  Score _latestScore;
  // If `true`, there were two human players in the game.
  bool _isTwoPlayer;
  // If `true`, settings must be changed before replaying.
  bool _mustChangeSettings = false;

  // Constructor.
  EndDisplay(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

  // Generate the message to display about the winner.
  String _getVictoryMessage() {
    if (_isTwoPlayer) {
      return (_latestScore.score1 > _latestScore.score2)
          ? PLAYER1_VICTORY_MESSAGE
          : PLAYER2_VICTORY_MESSAGE;
    } else {
      return (_latestScore.score1 > _latestScore.score2)
          ? HUMAN_VICTORY_MESSAGE
          : AI_VICTORY_MESSAGE;
    }
  }

  // Perform logical updates.
  void _update() {
    if (!_mouse.hasNewClick()) return;
    List<int> mouseCoordinates = _mouse.getClickCoordinates();
    int mouseX = mouseCoordinates[0];
    int mouseY = mouseCoordinates[1];
    if ((mouseX >= PLAY_AGAIN_BUTTON_X) &&
        (mouseX <= PLAY_AGAIN_BUTTON_X + PLAY_AGAIN_BUTTON_WIDTH) &&
        (mouseY >= PLAY_AGAIN_BUTTON_Y) &&
        (mouseY <= PLAY_AGAIN_BUTTON_Y + PLAY_AGAIN_BUTTON_HEIGHT)) {
      _mustChangeSettings = false;
      _isDone = true;
    } else if ((mouseX >= CHANGE_SETTINGS_BUTTON_X) &&
        (mouseX <= CHANGE_SETTINGS_BUTTON_X + CHANGE_SETTINGS_BUTTON_WIDTH) &&
        (mouseY >= CHANGE_SETTINGS_BUTTON_Y) &&
        (mouseY <= CHANGE_SETTINGS_BUTTON_Y + CHANGE_SETTINGS_BUTTON_HEIGHT)) {
      _mustChangeSettings = true;
      _isDone = true;
    }
  }

  // Display the updated state on the canvas.
  void _display() {
    clearDisplay();
    // Display victory message.
    canvasContext
      ..font = Display.FONT
      ..fillStyle = (_latestScore.score1 > _latestScore.score2
          ? Display.PLAYER1_COLOUR
          : Display.PLAYER2_COLOUR)
      ..fillText(_getVictoryMessage(), 300, 150);
    // Display button to play again.
    canvasContext
      ..fillStyle = Display.BUTTON_COLOUR
      ..fillRect(PLAY_AGAIN_BUTTON_X, PLAY_AGAIN_BUTTON_Y,
          PLAY_AGAIN_BUTTON_WIDTH, PLAY_AGAIN_BUTTON_HEIGHT)
      ..font = Display.FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText(PLAY_AGAIN_TEXT, (PLAY_AGAIN_BUTTON_X + 25),
          (PLAY_AGAIN_BUTTON_Y + PLAY_AGAIN_BUTTON_HEIGHT - 25));
    // Display button to change settings.
    canvasContext
      ..fillStyle = Display.BUTTON_COLOUR
      ..fillRect(CHANGE_SETTINGS_BUTTON_X, CHANGE_SETTINGS_BUTTON_Y,
          CHANGE_SETTINGS_BUTTON_WIDTH, CHANGE_SETTINGS_BUTTON_HEIGHT)
      ..font = Display.FONT
      ..fillStyle = Display.BALL_COLOUR
      ..fillText(CHANGE_SETTINGS_TEXT, (CHANGE_SETTINGS_BUTTON_X + 25),
          (CHANGE_SETTINGS_BUTTON_Y + CHANGE_SETTINGS_BUTTON_HEIGHT - 25));
  }

  // Execute any necessary game actions and draw the new state on the canvas.
  @override
  void updateAndDraw() {
    _update();
    _display();
  }

  // Return `true` if it's time to transition to the next display; else `false`.
  @override
  bool isDone() => _isDone;

  // Return the `Display` to its original state.
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

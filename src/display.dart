//
// Joseph Winters
// Parent class for display modes
// March 2018
//

import 'dart:html';

abstract class Display {
  // Player 1's colour.
  static const String PLAYER1_COLOUR = "red";
  // Player 2's colour.
  static const String PLAYER2_COLOUR = "blue";
  // Colour of the ball.
  static const String BALL_COLOUR = "white";
  // Colour of the background.
  static const String BACKGROUND_COLOUR = "black";
  // Usual colour of a button.
  static const String BUTTON_COLOUR = "#00cc03";
  // Default font to display text in.
  static const String FONT = "36pt IBM Plex Sans";
  // Monospace font to display text in.
  static const String MONO_FONT = "36pt IBM Plex Mono";

  // Canvas to draw the game on.
  final CanvasElement canvas;
  // Drawing context for the canvas.
  final CanvasRenderingContext2D canvasContext;
  // Constructor.
  Display(CanvasElement canvas)
      : canvas = canvas,
        canvasContext = canvas.getContext("2d");
  // Execute any necessary game actions and draw the new state on the canvas.
  void updateAndDraw();
  // Return `true` if it's time to transition to the next display; else `false`.
  bool isDone();
  // Return the `Display` to its original state.
  void reset();
  // Clear the canvas.
  void clearDisplay() {
    canvasContext
      ..fillStyle = BACKGROUND_COLOUR
      ..fillRect(0, 0, canvas.width, canvas.height);
  }
}

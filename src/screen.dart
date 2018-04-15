//
// Joseph Winters
// Parent class for display modes
// March 2018
//

abstract class Screen {
  // Canvas to draw the game on.
  final CanvasElement _canvas;
  // Drawing context for the canvas.
  final CanvasRenderingContext2D _canvasContext;
  // Constructor.
  Screen(CanvasElement canvas)
      : _canvas = canvas,
        _canvasContext = canvas.getContext("2d");
  // Execute any necessary game actions and draw the new state on the canvas.
  void updateAndDraw();
  // Return `true` if it's time to transition to the next screen; else `false`.
  bool isDone();
  // Return the `Screen` to its original state.
  void reset();
  // Clear the canvas.
  void _clearScreen() {
    _canvasContext
      ..fillStyle = "black"
      ..fillRect(0, 0, _canvas.width, _canvas.height);
  }
}

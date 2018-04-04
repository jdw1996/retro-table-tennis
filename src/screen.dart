//
// Joseph Winters
// Parent class for display modes
// March 2018
//

abstract class Screen {
  // Canvas to draw the game on.
  final CanvasElement _canvas;
  // Constructor.
  Screen(CanvasElement canvas) : _canvas = canvas;
  // Execute any necessary game actions and draw the new state on the canvas.
  void updateAndDraw();
  // Return `true` if it's time to transition to the next screen; else `false`.
  bool isDone();
  // Return the `Screen` to its original state.
  void reset();
}

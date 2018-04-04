//
// Joseph Winters
// Display introduction
// March 2018
//

import 'input.dart';
import 'screen.dart';

class IntroScreen extends Screen {
  bool _isDone = false;
  final Mouse _mouse;

  IntroScreen(CanvasElement canvas, Mouse mouse)
      : super(canvas),
        _mouse = mouse;

  void _display() {
    // TODO: Implement.
  }

  // Execute any necessary game actions and draw the new state on the canvas.
  void updateAndDraw() {
    // TODO: Implement.
  }

  // Return `true` if it's time to transition to the next screen; else `false`.
  bool isDone() => _isDone;

  // Return the `Screen` to its original state.
  @override
  void reset() {
    _isDone = false;
  }
}

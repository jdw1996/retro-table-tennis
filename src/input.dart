//
// Joseph Winters
// Classes for handling mouse and keyboard input
// March 2018
//

// The `Keyboard` class used here is taken from the following page:
// https://dart.academy/web-games-with-dart-and-the-html5-canvas/
// The `Mouse` class below is also based on this code.

class Keyboard {
  HashMap<int, num> _keys = new HashMap<int, num>();

  Keyboard() {
    window.onKeyDown.listen((KeyboardEvent event) {
      if (!_keys.containsKey(event.keyCode)) {
        _keys[event.keyCode] = event.timeStamp;
      }
    });

    window.onKeyUp.listen((KeyboardEvent event) {
      _keys.remove(event.keyCode);
    });
  }

  bool isPressed(int keyCode) => _keys.containsKey(keyCode);
}

class Mouse {
  int _clickX;
  int _clickY;
  bool _hasNewClick;

  // Constructor.
  Mouse() {
    window.onMouseDown.listen((MouseEvent event) {
      _clickX = event.offset.x;
      _clickY = event.offset.y;
      _hasNewClick = true;
    });
  }

  // Return `true` if there is a new click to process; else `false`.
  bool hasNewClick() {
    bool tmp = _hasNewClick;
    _hasNewClick = false;
    return tmp;
  }

  // Return the coordinates of the most recent click.
  List<int> getClickCoordinates() => [_clickX, _clickY];
}

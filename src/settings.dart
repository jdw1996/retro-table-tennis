//
// Joseph Winters
// Class for holding game settings
// July 2017
//

class Settings {
  bool isTwoPlayer;
  int playToScore;

  Settings(bool isTwoPlayer, int playToScore)
      : isTwoPlayer = isTwoPlayer,
        playToScore = playToScore;
}

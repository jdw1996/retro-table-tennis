//
// Joseph Winters
// Class for holding game settings
// July 2017
//

class Settings {
  // If `true`, there are two human players in the game; else one, plus an AI.
  bool isTwoPlayer;
  // Score to play to; first to reach it wins the game.
  int playToScore;

  // Constructor.
  Settings(bool isTwoPlayer, int playToScore)
      : isTwoPlayer = isTwoPlayer,
        playToScore = playToScore;
}

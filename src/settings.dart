//
// Joseph Winters
// Class for holding game settings
// July 2017
//

class Settings {
  bool isHumanPlayer1;
  bool isHumanPlayer2;
  int playToScore;

  Settings(bool isHumanPlayer1, bool isHumanPlayer2, int playToScore)
      : isHumanPlayer1 = isHumanPlayer1,
        isHumanPlayer2 = isHumanPlayer2,
        playToScore = playToScore;
}

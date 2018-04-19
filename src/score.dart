//
// Joseph Winters
// Class for holding game scores
// July 2017
//

class Score {
  int score1;
  int score2;

  // Constructor.
  Score(score1, score2)
      : score1 = score1,
        score2 = score2;

  // Reset the score to 0-0.
  void reset() {
    score1 = 0;
    score2 = 0;
  }
}

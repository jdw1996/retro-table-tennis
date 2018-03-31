//
// Joseph Winters
// Main execution
// July 2017
//

import 'score.dart';
import 'settings.dart';

void main() {
  // TODO: Define `IntroScreen`.
  IntroScreen introScreen = new IntroScreen();
  // TODO: Define `SettingsScreen`.
  SettingsScreen settingsScreen = new SettingsScreen();
  // TODO: Define `GameScreen`.
  GameScreen gameScreen = new GameScreen();
  // TODO: Define `EndScreen`.
  EndScreen endScreen = new EndScreen();

  Score latestScore = new Score(0, 0);
  Settings currentSettings = new Settings();
  bool changeSettings = true;

  introScreen.execute();
  while (true) {
    if (changeSettings) {
      settingsScreen.execute(currentSettings);
      currentSettings = settingsScreen.getSettings();
      changeSettings = false;
    }

    gameScreen.execute(currentSettings);
    latestScore = gameScreen.getScore();
    gameScreen.reset();

    endScreen.setScore(latestScore);
    endScreen.setIsTwoPlayer(currentSettings.isTwoPlayer);
    endScreen.execute();
    changeSettings = endScreen.mustChangeSettings();
  }
}

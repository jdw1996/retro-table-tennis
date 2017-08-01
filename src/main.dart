//
// Joseph Winters
// Main execution
// July 2017
//

import 'score.dart';

void main() {
  // TODO: define `IntroScreen`
  IntroScreen introScreen = new IntroScreen();
  // TODO: define `SettingsScreen`
  SettingsScreen settingsScreen = new SettingsScreen();
  // TODO: define `GameScreen`
  GameScreen gameScreen = new GameScreen();
  // TODO: define `EndScreen` as parent class of those below here
  // TODO: define `WinScreen`
  WinScreen winScreen = new WinScreen();
  // TODO: define `LoseScreen`
  LoseScreen loseScreen = new LoseScreen();
  // TODO: define `TwoPlayerEndScreen`
  TwoPlayerEndScreen twoPlayerEndScreen = new TwoPlayerEndScreen();

  Score latestScore = new Score(0, 0);
  // TODO: define `Settings`
  Settings currentSettings = new Settings();
  bool changeSettings = true;

  introScreen.execute();
  while (true) {
    if (changeSettings) {
      currentSettings = settingsScreen.execute(currentSettings);
      changeSettings = false;
    }
    latestScore = gameScreen.execute(currentSettings);
    // TODO: determine winner and execute `winScreen`, `loseScreen`, or `twoPlayerEndScreen`
    // NB: any of these `EndScreen`s should return a value on execution to indicate if settings must be changed
  }
}

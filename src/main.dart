//
// Joseph Winters
// Main execution
// July 2017
//

import 'score.dart';
import 'settings.dart';
import 'screen.dart';

void main() {
  Screen currentScreen;
  // TODO: Define `IntroScreen`.
  IntroScreen introScreen = new IntroScreen();
  // TODO: Define `SettingsScreen`.
  SettingsScreen settingsScreen = new SettingsScreen();
  // TODO: Define `GameScreen`.
  GameScreen gameScreen = new GameScreen();
  // TODO: Define `EndScreen`.
  EndScreen endScreen = new EndScreen();

  CanvasElement canvas = querySelector("#mycanvas");

  Score latestScore = new Score(0, 0);
  Settings currentSettings = new Settings();
  bool changeSettings = true;

  currentScreen = introScreen;
  canvas.onClick.listen((e) => currentScreen.handleClick(e));
  introScreen.execute();

  while (true) {
    if (changeSettings) {
      currentScreen = settingsScreen;
      settingsScreen.execute(currentSettings);
      currentSettings = settingsScreen.getSettings();
      changeSettings = false;
    }

    currentScreen = gameScreen;
    gameScreen.execute(currentSettings);
    latestScore = gameScreen.getScore();
    gameScreen.reset();

    currentScreen = endScreen;
    endScreen.setScore(latestScore);
    endScreen.setIsTwoPlayer(currentSettings.isTwoPlayer);
    endScreen.execute();
    changeSettings = endScreen.mustChangeSettings();
  }
}

//
// Joseph Winters
// Main execution
// July 2017
//


void main() {
  // TODO: define `Screen` as parent class of those in below block
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

  // TODO: define `Player`
  // NB: should be the parent class to `Human Player` and `ComputerPlayer`
  Player player1;
  Player player2;

  // TODO: define `Score`
  Score latestScore = new Score(0, 0);
  // TODO: define `Settings`
  Settings currentSettings = new Settings();
  bool changeSettings = true;

  IntroScreen.execute();
  while (true) {
    if (changeSettings) {
      // Pass `currentSettings` to display as defaults.
      // Update `currentSettings` with new choices.
      currentSettings = SettingsScreen.execute(currentSettings);
      // TODO: initialize `player1` and `player2` based on settings
      changeSettings = false;
    }
    latestScore = GameScreen.execute(playToScore);
    // TODO: determine winner and execute `winScreen`, `loseScreen`, or `twoPlayerEndScreen`
    // NB: any of these `EndScreen`s should return a value on execution to indicate if settings must be changed
  }
}

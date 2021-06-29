enum Mode {
  mixed_cards,
  pure_suit,
}

class Config {
  int _numCards = 5;
  int _numRounds = 3;
  Mode _mode = Mode.mixed_cards;
  bool _debug = true;

  Config._();

  Config.provided(this._numCards, this._numRounds, this._mode, this._debug);

  static Config instance = Config._();

  int get numCards => _numCards;
  Mode get mode => _mode;
  int get numRounds => _numRounds;
  bool get debug => _debug;
}

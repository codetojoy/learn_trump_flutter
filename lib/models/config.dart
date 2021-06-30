enum Mode {
  mixed_cards,
  pure_suit,
}

class Config {
  int numCards = 5;
  int numRounds = 3;
  Mode mode = Mode.mixed_cards;
  bool debug = true;

  Config._();

  Config.provided(this.numCards, this.numRounds, this.mode, this.debug);

  static Config instance = Config._();

  bool isValidNumRounds(String? value) {
    var result = false;
    if (value != null) {
      var tmpValue = int.tryParse(value);
      if (tmpValue != null) {
        result = tmpValue > 0;
      }
    }
    return result;
  }

  @override
  String toString() {
    return 'config: c: $numCards, r: $numRounds, m: $mode, d: $debug';
  }
}

class RoundInfo {
  var firstGuess = true;
  var roundNum = 1;
  var numCorrect = 0;
  var _maxNumRounds = 0;

  RoundInfo.init(int maxNumRounds) {
    _maxNumRounds = maxNumRounds;
  }

  RoundInfo(
      this.firstGuess, this.roundNum, this.numCorrect, this._maxNumRounds);

  bool get isDone => roundNum > _maxNumRounds;

  RoundInfo nextRound() {
    return RoundInfo(true, roundNum + 1, numCorrect, _maxNumRounds);
  }

  RoundInfo correctGuess() {
    final newNumCorrect = (firstGuess) ? numCorrect + 1 : numCorrect;
    return RoundInfo(firstGuess, roundNum, newNumCorrect, _maxNumRounds);
  }

  RoundInfo wrongGuess() {
    return RoundInfo(false, roundNum, numCorrect, _maxNumRounds);
  }

  @override
  String toString() {
    return '$numCorrect / $roundNum';
  }
}

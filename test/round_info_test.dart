import 'package:test/test.dart';

import 'package:learn_trump_flutter/models/round_info.dart';

void main() {
  group('RoundInfo', () {
    final maxNumRounds = 5;
    setUp(() {});

    test('ctor', () {
      // test
      var roundInfo = RoundInfo.init(maxNumRounds);

      expect(roundInfo.firstGuess, true);
      expect(roundInfo.numCorrect, 0);
      expect(roundInfo.isDone, false);
      expect(roundInfo.roundNum, 1);
    });
    test('correctGuess', () {
      var roundInfo = RoundInfo.init(maxNumRounds);

      // test
      roundInfo = roundInfo.correctGuess();

      expect(roundInfo.firstGuess, true);
      expect(roundInfo.numCorrect, 1);
      expect(roundInfo.isDone, false);
      expect(roundInfo.roundNum, 1);
    });
    test('wrongGuess case 1', () {
      var roundInfo = RoundInfo.init(maxNumRounds);

      // test
      roundInfo = roundInfo.wrongGuess();

      expect(roundInfo.firstGuess, false);
      expect(roundInfo.numCorrect, 0);
      expect(roundInfo.isDone, false);
      expect(roundInfo.roundNum, 1);
    });
    test('wrongGuess case 2', () {
      var roundInfo = RoundInfo.init(maxNumRounds);

      // test
      roundInfo = roundInfo.wrongGuess();
      roundInfo = roundInfo.wrongGuess();
      roundInfo = roundInfo.wrongGuess();

      expect(roundInfo.firstGuess, false);
      expect(roundInfo.numCorrect, 0);
      expect(roundInfo.isDone, false);
      expect(roundInfo.roundNum, 1);
    });
    test('nextRound', () {
      var roundInfo = RoundInfo.init(maxNumRounds);
      roundInfo = roundInfo.correctGuess();

      expect(roundInfo.firstGuess, true);
      expect(roundInfo.numCorrect, 1);
      expect(roundInfo.roundNum, 1);

      // test
      roundInfo = roundInfo.nextRound();

      expect(roundInfo.firstGuess, true);
      expect(roundInfo.numCorrect, 1);
      expect(roundInfo.roundNum, 2);
    });
    test('isDone', () {
      var roundInfo = RoundInfo.init(3);
      roundInfo = roundInfo.correctGuess();
      roundInfo = roundInfo.nextRound();
      roundInfo = roundInfo.correctGuess();
      roundInfo = roundInfo.nextRound();
      roundInfo = roundInfo.correctGuess();
      roundInfo = roundInfo.nextRound();

      // test
      expect(roundInfo.isDone, true);

      expect(roundInfo.numCorrect, 3);
      expect(roundInfo.roundNum, 4);
    });
  }); // group
}

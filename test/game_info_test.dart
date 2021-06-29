import 'package:test/test.dart';

import 'package:learn_trump_flutter/models/card.dart';
import 'package:learn_trump_flutter/models/config.dart';
import 'package:learn_trump_flutter/models/game_info.dart';

void main() {
  group('GameInfo', () {
    final numCards = 5;
    final numRounds = 3;
    setUp(() {});

    test('newGame', () {
      final config =
          Config.provided(numCards, numRounds, Mode.mixed_cards, false);
      final gameInfo = GameInfo(config);

      // test
      gameInfo.newGame();

      expect(gameInfo.isOngoing, true);
      expect(gameInfo.isUnknown, false);
    });
    test('newRound mixed', () {
      final config =
          Config.provided(numCards, numRounds, Mode.mixed_cards, false);
      final gameInfo = GameInfo(config);
      gameInfo.newGame();

      // test
      gameInfo.newRound();

      expect(gameInfo.isOngoing, true);
      expect(gameInfo.isUnknown, false);
      expect(gameInfo.trumpSuit != Suit.UNKNOWN, true);
      expect(gameInfo.leadingSuit != Suit.UNKNOWN, true);
    });
    test('newRound pure', () {
      final config =
          Config.provided(numCards, numRounds, Mode.pure_suit, false);
      final gameInfo = GameInfo(config);
      gameInfo.newGame();

      // test
      gameInfo.newRound();

      expect(gameInfo.isOngoing, true);
      expect(gameInfo.isUnknown, false);
      expect(gameInfo.trumpSuit != Suit.UNKNOWN, true);
      expect(gameInfo.leadingSuit == Suit.UNKNOWN, true);
    });
  }); // group
}

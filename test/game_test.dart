import 'package:test/test.dart';

import 'package:learn_trump_flutter/models/card.dart';
import 'package:learn_trump_flutter/models/hand.dart';
import 'package:learn_trump_flutter/models/config.dart';
import 'package:learn_trump_flutter/models/game_info.dart';
import 'package:learn_trump_flutter/services/game.dart';

void main() {
  group('Game', () {
    final numCards = 5;
    final numRounds = 3;
    setUp(() {});

    int countBySuit(Hand hand, Suit suit) {
      return hand.cards
          .map((c) => c.suit == suit ? 1 : 0)
          .reduce((v, e) => v + e);
    }

    test('getHand mixed', () {
      final config =
          Config.provided(numCards, numRounds, Mode.mixed_cards, false);
      final gameInfo = GameInfo(config);
      final game = Game(gameInfo);

      // test
      final hand = game.getHand();

      int numSuits = 0;
      numSuits += countBySuit(hand, Suit.CLUBS);
      numSuits += countBySuit(hand, Suit.DIAMONDS);
      numSuits += countBySuit(hand, Suit.HEARTS);
      numSuits += countBySuit(hand, Suit.SPADES);
      expect(hand.cards.length, numCards);
      expect(numSuits > 1, true);
    });
  }); // group
}

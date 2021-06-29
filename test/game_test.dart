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

    bool containsSuit(Hand hand, Suit suit) {
      bool result = false;
      hand.cards.forEach((card) {
        result = result || card.suit == suit;
      });
      return result;
    }

    test('getHand mixed', () {
      final config =
          Config.provided(numCards, numRounds, Mode.mixed_cards, false);
      final gameInfo = GameInfo(config);
      final game = Game(gameInfo);

      // test
      final hand = game.getHand();

      expect(hand.cards.length, numCards);
      int numSuits = 0;
      numSuits += containsSuit(hand, Suit.CLUBS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.DIAMONDS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.HEARTS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.SPADES) ? 1 : 0;
      expect(numSuits > 1, true);
    });
    test('getHand pure', () {
      final config =
          Config.provided(numCards, numRounds, Mode.pure_suit, false);
      final gameInfo = GameInfo(config);
      final game = Game(gameInfo);

      // test
      final hand = game.getHand();

      expect(hand.cards.length, numCards);
      int numSuits = 0;
      numSuits += containsSuit(hand, Suit.CLUBS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.DIAMONDS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.HEARTS) ? 1 : 0;
      numSuits += containsSuit(hand, Suit.SPADES) ? 1 : 0;
      expect(numSuits, 1);
    });
  }); // group
}

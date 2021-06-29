import '../models/config.dart';
import '../models/card.dart';
import '../models/cards.dart';
import '../models/deck.dart';
import '../models/game_info.dart';
import '../models/hand.dart';
import './ranker.dart';

// this is round, not game ??
class Game {
  late final Suit _trumpSuit;
  late final Suit _leadingSuit;
  late final Ranker _ranker;
  late final Mode _mode;
  late final int _numCards;

  Game(GameInfo gameInfo) {
    _trumpSuit = gameInfo.trumpSuit;
    _leadingSuit = gameInfo.leadingSuit;
    _ranker = Ranker(_trumpSuit, _leadingSuit);
    _mode = gameInfo.mode;
    _numCards = gameInfo.numCards;
  }

  Hand getHand() {
    var cards;
    if (_mode == Mode.mixed_cards) {
      final deck = Deck();
      deck.shuffle();
      cards = deck.take(_numCards);
    } else {
      cards = C.getRandomBySuit(_trumpSuit, _numCards);
    }
    return Hand.provide(cards);
  }

  bool isCorrect(List<Card> cards, Card selection) {
    final topCards = _ranker.getTopRankedCards(cards);
    final result = topCards.contains(selection);
    return result;
  }
}

import '../models/config.dart';
import '../models/card.dart';
import '../models/cards.dart';
import '../models/deck.dart';
import './ranker.dart';

class Game {
  late final Suit _trumpSuit;
  late final Suit _leadingSuit;
  late final Ranker _ranker;
  late final Mode _mode;
  late final int _numCards;

  Game(Suit trumpSuit, Suit leadingSuit, Mode mode, int numCards) {
    _trumpSuit = trumpSuit;
    _leadingSuit = leadingSuit;
    _ranker = Ranker(_trumpSuit, _leadingSuit);
    _mode = mode;
    _numCards = numCards;
  }

  List<Card> getCards() {
    var cards;
    if (_mode == Mode.mixed_cards) {
      final deck = Deck();
      deck.shuffle();
      cards = deck.take(_numCards);
    } else {
      cards = C.getRandomBySuit(_trumpSuit, _numCards);
    }
    return cards;
  }

  bool isCorrect(List<Card> cards, Card selection) {
    final topCards = _ranker.getTopRankedCards(cards);
    final result = topCards.contains(selection);
    return result;
  }

/*
  Card _getSelection(List<Card> cards) {
    var result = C.UNKNOWN;
    var done = false;

    while (!done) {
      stdout.writeln('enter your choice (q to quit): ');
      final input = stdin.readLineSync();
      if (input! == 'q') {
        stdout.writeln('OK quitting...');
        exit(0);
      }
      final choiceIndex = int.parse(input);
      final ok = choiceIndex >= 1 && choiceIndex <= cards.length;
      if (ok) {
        result = cards[choiceIndex - 1];
        done = true;
      } else {
        stdout.writeln('illegal choice');
      }
    }
    return result;
  }

  RoundInfo playRound(RoundInfo inRoundInfo) {
    var roundInfo = inRoundInfo;
    final trumpSuit = Suits().getRandom();
    final leadingSuit = Suits().getRandom();
    final cards = _getCards(trumpSuit);
    final ranker = Ranker(trumpSuit, leadingSuit);
    final topCards = ranker.getTopRankedCards(cards);

    var done = false;

    while (!done) {
      stdout.writeln('trumpSuit: $trumpSuit');
      stdout.writeln('leadingSuit: $leadingSuit');
      stdout.writeln('cards: $cards');

      if (Config.instance.debug) {
        stdout.writeln('top cards: $topCards');
        var sortedCards = List<Card>.from(cards);
        ranker.customSortArray(sortedCards);
        stdout.writeln('sorted cards: $sortedCards');
      }

      final selection = _getSelection(cards);

      if (topCards.contains(selection)) {
        stdout.writeln('correct!');
        roundInfo = roundInfo.correctGuess();
        stdout.writeln('$roundInfo');
        done = true;
      } else {
        stdout.writeln('try again');
        roundInfo = roundInfo.wrongGuess();
      }
    }

    return roundInfo;
  }

  void play() {
    var roundInfo = RoundInfo.init(Config.instance.numRounds);

    while (!roundInfo.isDone()) {
      roundInfo = playRound(roundInfo);
      if (roundInfo.isDone()) {
        stdout.writeln('final score $roundInfo');
      } else {
        roundInfo = roundInfo.nextRound();
      }
    }
  }
  */
}

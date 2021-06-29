import './config.dart';
import './card.dart';
import './hand.dart';
import './round_info.dart';

class GameInfo {
  late RoundInfo roundInfo;
  Suit trumpSuit = Suit.UNKNOWN;
  Suit leadingSuit = Suit.UNKNOWN;
  late Hand hand;
  late Mode mode;
  int numCards = 0;

  bool _inProgress = false;
  bool _unknown = true;
  late Config _config;

  GameInfo.unknown(Config config) {
    _config = config;
    roundInfo = RoundInfo.init(_config.numRounds);
  }

  GameInfo(Config config) {
    _unknown = false;
    _config = config;
    mode = config.mode;
    numCards = config.numCards;
    roundInfo = RoundInfo.init(_config.numRounds);
    trumpSuit = Suits().getRandom();
    leadingSuit = Suits().getRandom();
    _inProgress = true;
  }

  bool get isUnknown => _unknown;
  bool get ongoing => _inProgress && !roundInfo.isDone;

  void setHand(Hand hand) {
    this.hand = hand;
  }

  void newRound() {
    trumpSuit = Suits().getRandom();
    leadingSuit = Suits().getRandom();
  }

  void newGame() {
    _inProgress = true;
    roundInfo = RoundInfo.init(_config.numRounds);
  }

  bool get isDone => roundInfo.isDone;

  void roundOver() {
    roundInfo = roundInfo.nextRound();
  }

  void correctGuess() {
    roundInfo = roundInfo.correctGuess();
  }

  void wrongGuess() {
    roundInfo = roundInfo.wrongGuess();
  }
}

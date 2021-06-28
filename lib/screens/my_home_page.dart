import 'package:flutter/material.dart';

import './about.dart';
import './config.dart';
import './help.dart';
import '../models/cards.dart';
import '../models/card.dart' as m;
import '../models/hand.dart';
import '../models/config.dart' as m;
import '../models/round_info.dart';
import '../widgets/hand.dart';
import '../widgets/score.dart';
import '../widgets/suits.dart';
import '../utils/logger.dart';
import '../services/game.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppBar _appBar;
  bool _inProgress = false;
  bool _gameOver = false;
  late RoundInfo _roundInfo;
  // TODO: maybe put into Game
  late m.Suit _trumpSuit;
  late m.Suit _leadingSuit;
  late Hand _hand;
  late Game _game;
  final _config = m.Config.instance;

  void _newRound() {
    _trumpSuit = m.Suits().getRandom();
    _leadingSuit = m.Suits().getRandom();
    _game = Game(_trumpSuit, _leadingSuit, _config.mode, _config.numCards);
    final cards = _game.getCards();
    _hand = Hand.provide(cards);
  }

  void _newGame() {
    setState(() {
      if (!_inProgress || (_inProgress && _gameOver)) {
        _inProgress = true;
        _gameOver = false;
        _roundInfo = RoundInfo.init(_config.numRounds);
        _newRound();
      }
    });
  }

  void _selectCard(m.Card selection) {
    setState(() {
      bool isCorrect = _game.isCorrect(_hand.cards, selection);
      if (isCorrect) {
        _roundInfo = _roundInfo.correctGuess();
        _newRound();
      } else {
        _roundInfo = _roundInfo.wrongGuess();
      }
      _gameOver = _roundInfo.isDone;
      _roundInfo = _roundInfo.nextRound();
      L.log('play c: $selection ri: $_roundInfo');
    });
  }

  void _pushAbout() {
    Navigator.of(context).pushNamed(About.routeName);
  }

  void _pushConfig() {
    Navigator.of(context).pushNamed(Config.routeName);
  }

  void _pushHelp() {
    Navigator.of(context).pushNamed(Help.routeName);
  }

  @override
  Widget build(BuildContext context) {
    _appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(icon: Icon(Icons.help_outline), onPressed: _pushHelp),
        IconButton(icon: Icon(Icons.info), onPressed: _pushAbout),
        IconButton(icon: Icon(Icons.settings), onPressed: _pushConfig),
      ],
    );

    var widgets = <Widget>[];

    if (_inProgress && !_gameOver) {
      widgets = [
        Score(_roundInfo),
        Suits(_trumpSuit, _leadingSuit),
        HandWidget(_hand, _selectCard, true),
      ];
    } else if (_inProgress && _gameOver) {
      widgets = [
        Text('Final score:'),
        Score(_roundInfo),
        Text('click new to continue'),
      ];
    } else {
      widgets = [
        Text('click new:'),
      ];
    }

    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newGame,
        tooltip: 'New Game',
        child: Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import './about.dart';
import './config.dart';
import './help.dart';
import '../models/card.dart' as m;
import '../models/config.dart' as m;
import '../models/game_info.dart';
import '../widgets/hand.dart';
import '../widgets/score.dart';
import '../widgets/suits.dart';
import '../services/game.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppBar _appBar;
  final config = m.Config.instance;
  late GameInfo _gameInfo = GameInfo.unknown(config);
  late Game _game;

  void _newRound() {
    final hand = _game.getHand();
    _gameInfo.setHand(hand);
  }

  void _newGame() {
    setState(() {
      L.log('new game with $config');
      if (_gameInfo.isUnknown || !_gameInfo.isOngoing) {
        _gameInfo = GameInfo(config);
        _game = Game(_gameInfo);
        _newRound();
      } else {
        L.log('denied: create a new game');
      }
    });
  }

  void _cancelGame() {
    setState(() {
      _gameInfo = GameInfo.unknown(config);
    });
  }

  void _selectCard(m.Card selection) {
    setState(() {
      bool isCorrect = _game.isCorrect(_gameInfo.hand.cards, selection);
      if (isCorrect) {
        _gameInfo.correctGuess();
        _newRound();
      } else {
        _gameInfo.wrongGuess();
      }
      _gameInfo.roundOver();
      L.log('play c: $selection gi: $_gameInfo');
    });
  }

  void _pushAbout() {
    Navigator.of(context).pushNamed(About.routeName);
  }

  void _pushConfig() {
    Navigator.of(context).pushNamed(ConfigForm.routeName,
        arguments: {Const.CONFIG_PARAM: m.Config.instance});
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

    if (_gameInfo.isOngoing) {
      widgets = [
        Score(_gameInfo.roundInfo),
        Suits(_gameInfo.trumpSuit, _gameInfo.leadingSuit),
        HandWidget(_gameInfo.hand, _selectCard, true),
      ];
    } else if (_gameInfo.isDone) {
      widgets = [
        Text('Final score:'),
        Score(_gameInfo.roundInfo),
        Text('click new to continue'),
      ];
    } else {
      widgets = [
        Text('click new:'),
      ];
    }

    var actionButton = (_gameInfo.isOngoing)
        ? FloatingActionButton(
            onPressed: _cancelGame,
            tooltip: Const.QUIT_GAME,
            child: Icon(Icons.cancel),
          )
        : FloatingActionButton(
            onPressed: _newGame,
            tooltip: Const.NEW_GAME,
            child: Icon(Icons.add),
          );

    return Scaffold(
      appBar: _appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widgets,
        ),
      ),
      floatingActionButton: actionButton,
    );
  }
}

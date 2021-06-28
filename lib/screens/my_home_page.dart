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
  late RoundInfo _roundInfo;
  late m.Suit _trumpSuit;
  late m.Suit _leadingSuit;
  late Hand _hand;
  late Game _game;

  void _newGame() {
    setState(() {
      _inProgress = true;
      _trumpSuit = m.Suits().getRandom();
      _leadingSuit = m.Suits().getRandom();
      final config = m.Config.instance;
      _roundInfo = RoundInfo.init(config.numRounds);
      _game = Game(_trumpSuit, _leadingSuit, config.mode, config.numCards);
      final cards = _game.getCards();
      _hand = Hand.provide(cards);
    });
  }

  void _selectCard(m.Card card) {
    setState(() {
      L.log('card selected: $card');
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

    if (_inProgress) {
      widgets = [
        Score(_roundInfo.numCorrect, _roundInfo.roundNum),
        Suits(_trumpSuit, _leadingSuit),
        Text('hand:'),
        HandWidget(_hand, _selectCard, true),
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

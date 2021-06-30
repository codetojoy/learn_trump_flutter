import 'package:flutter/material.dart';

import '../models/card.dart' as m;
import '../models/cards.dart';
import '../models/config.dart';

class Suits extends StatelessWidget {
  final m.Suit _trumpSuit;
  final m.Suit _leadingSuit;
  final Mode _mode;

  Suits(this._trumpSuit, this._leadingSuit, this._mode);

  @override
  Widget build(BuildContext context) {
    final trumpSuitURL = C.imageURL(_trumpSuit);
    final leadingSuitURL = C.imageURL(_leadingSuit);
    return Row(children: [
      Text('trump:'),
      Container(
          height: 20,
          child: Image.asset(
            trumpSuitURL,
            fit: BoxFit.cover,
          )),
      if (_mode == Mode.mixed_cards) Text('leading:'),
      if (_mode == Mode.mixed_cards)
        Container(
            height: 20,
            child: Image.asset(
              leadingSuitURL,
              fit: BoxFit.cover,
            )),
    ]);
    /*
    return Container(
      child: Text('trump: $_trumpSuit leading: $_leadingSuit'),
    );
    */
  }
}

import 'package:flutter/material.dart';

import '../models/card.dart' as m;
import '../utils/constants.dart';

class Suits extends StatelessWidget {
  final m.Suit _trumpSuit;
  final m.Suit _leadingSuit;

  Suits(this._trumpSuit, this._leadingSuit);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('trump: $_trumpSuit leading: $_leadingSuit'),
    );
  }
}

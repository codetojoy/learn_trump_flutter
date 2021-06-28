import 'package:flutter/material.dart';

import '../models/card.dart' as waro_c;
import '../utils/constants.dart';

class CardWidget extends StatelessWidget {
  final waro_c.Card _card;
  final Function _selectHandler;
  final bool _faceUp;

  CardWidget(this._card, this._selectHandler, this._faceUp);

  @override
  Widget build(BuildContext context) {
    var imageURL = (_faceUp) ? _card.imageURL : Const.BLUE_BACK;
    return Container(
                  height: 100,
                  child: Image.asset(
                    imageURL,
                    fit: BoxFit.cover,
                  ));
  }
}
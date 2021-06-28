import 'package:flutter/material.dart';

import '../models/round_info.dart';

class Score extends StatelessWidget {
  RoundInfo _roundInfo;

  Score(this._roundInfo);

  @override
  Widget build(BuildContext context) {
    final roundNum = _roundInfo.roundNum;
    final numCorrect = _roundInfo.numCorrect;
    final numTurns = roundNum - 1;
    return Container(
      child: Text('R $roundNum score: $numCorrect / $numTurns'),
    );
  }
}

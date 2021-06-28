import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  int _numCorrect;
  int _numRounds;

  Score(this._numCorrect, this._numRounds);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('score: $_numCorrect / $_numRounds'),
    );
  }
}

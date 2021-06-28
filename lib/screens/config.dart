import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import '../widgets/utils/my_media_query.dart';

class Config extends StatelessWidget {
  static const routeName = '/config';

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text(Const.CONFIG));
    return Scaffold(
      appBar: appBar,
      body: _build(context, appBar),
    );
  }

  Widget _build(BuildContext context, AppBar appBar) {
    final textStyle = Theme.of(context).textTheme.headline6;

    return Card(
        child: Center(
            child: Column(children: [
          Text('TODO: config', style: textStyle),
        ])),
        elevation: 10);
  }
}

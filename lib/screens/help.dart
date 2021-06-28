import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import '../widgets/utils/my_media_query.dart';

class Help extends StatelessWidget {
  static const routeName = '/help';

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text(Const.HELP));
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
          Text('TODO: help here', style: textStyle),
        ])),
        elevation: 10);
  }
}

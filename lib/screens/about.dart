import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/constants.dart';
import '../widgets/utils/my_media_query.dart';

class About extends StatelessWidget {
  static const routeName = '/about';

  String _version() {
    var version = "v 28-JUN";
    // TODO: this should be a compile-time stamp, based on build
    var now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    return '$version $now';
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(title: Text(Const.ABOUT));
    return Scaffold(
      appBar: appBar,
      body: _build(context, appBar),
    );
  }

  Widget _build(BuildContext context, AppBar appBar) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var orientation = (isLandscape) ? 'landscape' : 'portrait';
    var myMediaQuery = MyMediaQuery.simple(context, appBar);
    var availableHeight = myMediaQuery.availableHeight;
    var totalHeight = myMediaQuery.totalHeight;
    var totalWidth = myMediaQuery.totalWidth;
    var textStyle = Theme.of(context).textTheme.headline6;
    return Card(
        child: Center(
            child: Column(children: [
          Text('version: ${_version()}', style: textStyle),
          Text('orientation: ${orientation}', style: textStyle),
          Text('total height: ${totalHeight}', style: textStyle),
          Text('available height: ${availableHeight}', style: textStyle),
          Text('total width: ${totalWidth}', style: textStyle),
          Text('num players: TODO', style: textStyle),
        ])),
        elevation: 10);
  }
}

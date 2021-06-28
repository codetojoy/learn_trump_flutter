import 'package:flutter/material.dart';

import './screens/about.dart';
import './screens/my_home_page.dart';
import './utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: Const.TITLE,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Const.ROOT_ROUTE,
        routes: {
          Const.ROOT_ROUTE: (ctx) => MyHomePage(title: Const.TITLE),
          About.routeName: (ctx) => About(),
        });
  }
}

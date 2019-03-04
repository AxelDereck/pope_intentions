import 'package:flutter/material.dart';

import 'home.dart';
import 'package:pope_intentions/model/Intention.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dataLoading();
    return MaterialApp(
      title: 'Intentions du Pape 2019',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Intentions du Pape 2019'),
    );
  }
}

dataLoading() async {
  await loadIntentions();
}
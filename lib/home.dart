import 'package:flutter/material.dart';

import 'package:pope_intentions/model/Intention.dart';
import 'package:pope_intentions/widget/IntentionWidget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Intention _curIntention;

  @override
  void initState() {
    super.initState();
    //_intentions = loadIntentions();
    // FutureBuilder<List<Intention>>(
    /*
    FutureBuilder<dynamic>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          data.forEach((line) {
            Intention nIntention = Intention.fromJson(line);
            setState(() {
              _intentions.add(nIntention);
            });
            // print("$line");
          });
        } else {}
      },
    );
    */
    //loadIntentions();
    _showTodayIntention();
    _curIntention = new Intention("feb-2019", 2019, "Février", "La traite des personnes : Pour l’accueil généreux des victimes de la traite des personnes, de la prostitution forcée et de la violence.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
/*
          IconButton(
            icon: Icon(Icons.today, color: Colors.white),
            tooltip: 'Intention de ce mois',
            onPressed: _showTodayIntention(),
          ),
*/
          IconButton(
            icon: Icon(Icons.today, color: Colors.white),
            tooltip: 'Sélectionner un autre mois',
            onPressed: () {
              print(">>>>  tap HERE !!!");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IntentionWidget(
                    callback: _successSelectionIntention
                  )
                )
              );
            },
          )
        ],
      ),
      body: _buildGUI(),
    );
  }

  Widget _buildGUI() {
    return ListView(
      padding: const EdgeInsets.only(top: 30.0),
      children: <Widget>[
        ListTile(
          title: Center(
            child: Text(_selectedIntentionName(), style: TextStyle(fontSize: 21, fontFamily: 'Candara', color: Colors.brown),),
          )
        ),
        ListTile(
          title: _selectedText(),
        )
      ]
    );
  }

  Widget _selectedText() {
    return Center(
      child: Text(
        _curIntention.text,
        style: TextStyle(fontSize: 30),
      )
    );
  }

  String _selectedIntentionName() {
    return "${_curIntention.month} ${_curIntention.year}";
  }

  _showTodayIntention() {
    if(0 < Intention.intentions.length) {
      var curMonth = DateTime.now().month - 1;
      print('Chargement de l\'intention du jour : $curMonth');
      setState(() {
        _curIntention =Intention.intentions[curMonth];
      });
    }
  }

  void _successSelectionIntention(Intention selectedIntention) {
    setState(() {
      _curIntention = selectedIntention;
    });
  }
 }

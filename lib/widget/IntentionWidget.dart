import 'package:flutter/material.dart';

import 'package:pope_intentions/model/Intention.dart';

typedef void IntentionCallback(Intention intention);
typedef void VoidCallback();

class IntentionWidget extends StatefulWidget {

  IntentionWidget({Key key, this.callback}) : super(key: key);

  final IntentionCallback callback;

  @override
  _IntentionWidgetState createState() => new _IntentionWidgetState();
}

class _IntentionWidgetState extends State<IntentionWidget> {
  Intention _curIntention;

  @override
  Widget build(BuildContext context) {
    print('Nb intentions retrieved : ${Intention.intentions.length}');
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: new Scaffold(
          appBar: _buildAppBar(),
          backgroundColor: Colors.white,
          body: ListView.builder(
            itemCount: Intention.intentions.length,
            itemBuilder: (BuildContext context, int index) {
              return new Column(
                children: <Widget>[
                  new ListTile(
                    onTap: () {
                      _intentionSelected(Intention.intentions[index]);
                    },
                    leading: Icon(Icons.map, color: Colors.blue,),
                    title: Text(
                      "${Intention.intentions[index].month} ${Intention.intentions[index].year}",
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  new Divider(height: 0.0, indent: 2.0, color: Colors.grey,),
                ],
              );
            }
          ),
        )
    );
  }

  void _intentionSelected(Intention intention) {
    _curIntention = intention;
    widget.callback(_curIntention);
    Navigator.of(context).pop();
  }

  void _navigateBackToParent() {
    Navigator.of(context).pop();
  }

  Widget _buildAppBar() {
    return new AppBar(
      title: new Text(
        "Sélectionner le mois de votre choix",
        style: new TextStyle(color: Colors.blue, fontSize: 15.0),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: new IconButton(
          padding: const EdgeInsets.all(18.0),
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () => _navigateBackToParent()
      ),
    );
  }

}
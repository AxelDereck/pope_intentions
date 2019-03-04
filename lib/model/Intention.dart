import 'dart:async' show Future;
import 'dart:convert' show json;
import 'package:flutter/services.dart' show rootBundle;

class Intention {
  static List<Intention> intentions;
  int year;
  String key;
  String month;
  String text;

  Intention(this.key, this.year, this.month, this.text);

  factory Intention.fromJson(Map<String, dynamic> jsonMap) {
    return new Intention(jsonMap['key'], jsonMap['year'], jsonMap['month'], jsonMap['text']);
  }
}

Future<int> loadIntentions() async {
  Intention.intentions = new List();
  var data = await getData();
  data.forEach((line) {
    Intention nIntention = Intention.fromJson(line);
    Intention.intentions.add(nIntention);
    // print("$line");
  });
  return Intention.intentions.length;
}

Future<dynamic> getData() async {
  String jsonString = await _loadAsset();
  final jsonResponse = json.decode(jsonString);
  final lines = jsonResponse['intentions'];
  return lines;
}

Future<String> _loadAsset() async {
  return await rootBundle.loadString('assets/intentions-2019.json');
}

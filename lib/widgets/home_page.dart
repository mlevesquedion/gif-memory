import 'package:flutter/material.dart';

import 'memory_game.dart';

class HomePage extends StatelessWidget {
  final _gifQueryController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Column(children: <Widget>[
          Row(children: <Widget>[
            Expanded(
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What kind of gifs do you want?'),
                    controller: _gifQueryController)),
            RaisedButton(child: Text('Play'), onPressed: () => _play(context)),
          ]),
        ]));
  }

  void _play(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoryGame(_gifQueryController.text)));
  }
}

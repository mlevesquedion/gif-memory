import 'package:flutter/material.dart';

import 'memory_game.dart';

class HomePage extends StatelessWidget {
  final _gifQueryController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash Memory"),
      ),
      body: Column(children: <Widget>[
        Center(
            child: Container(
                width: 300.0,
                child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(40.0),
                        hintText: "What kind of gifs do you want?"),
                    controller: _gifQueryController))),
        RaisedButton(child: Text("Play"), onPressed: () => _play(context)),
      ]),
    );
  }

  void _play(context) {
    String gifQuery = _gifQueryController.text;
    if (gifQuery.isEmpty) {
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MemoryGame(_gifQueryController.text)));
  }
}

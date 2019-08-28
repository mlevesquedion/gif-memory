import 'dart:async';

import 'package:flash_memory/network/gif_api.dart' as gif_api;
import 'package:flutter/material.dart';

import '../constants.dart';
import '../domain/gif_card.dart';
import '../domain/gif_card_collection.dart';

class MemoryGame extends StatefulWidget {
  MemoryGame(this.gifQuery);

  String gifQuery;

  @override
  _MemoryGameState createState() {
    return _MemoryGameState(gif_api.get(gifQuery));
  }
}

class _MemoryGameState extends State<MemoryGame> {
  GifCardCollection _game;
  Future<List<GifCard>> _gifs;
  int _offset = 0;

  bool _hidingPendingCards = false;

  _MemoryGameState(this._gifs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(APP_TITLE),
        ),
        body: Center(
          child: FutureBuilder<List<GifCard>>(
            future: _gifs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (_game == null) {
                  _initializeGame();
                  return CircularProgressIndicator();
                }
                return _buildGrid();
              } else if (snapshot.hasError) {
                return Text(
                  "An error has occured.\nTry again with a different kind of gif!",
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  _buildGrid() {
    return GridView.count(
        padding: EdgeInsets.all(10),
        crossAxisCount: GAME_DIMENSION,
        children: List.generate(_game.cards.length, (index) {
          return Center(
              child: FlatButton(
                  padding: EdgeInsets.symmetric(),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () => setState(() {
                        _revealAt(index);
                      }),
                  child: _game.isRevealedAt(index)
                      ? Image.network(_game.faceAt(index))
                      : Container(color: Colors.black45)));
        }));
  }

  _revealAt(int index) async {
    if (_hidingPendingCards) {
      setState(() => {});
      return;
    }

    setState(() => _game.revealAt(index));

    if (_game.shouldHidePendingCards) {
      _hidingPendingCards = true;
      Timer(Duration(seconds: 1), () {
        setState(() => _game.hidePendingCards());
        _hidingPendingCards = false;
      });
    }

    if (_game.isOver()) {
      GameOverChoice choice = await showGameOverDialog(context);
      handleGameOverChoice(choice);
    }
  }

  void handleGameOverChoice(GameOverChoice choice) {
    switch (choice) {
      case GameOverChoice.PLAY_AGAIN_WITH_SAME_GIFS:
        setState(() => _game.reset());
        break;
      case GameOverChoice.PLAY_AGAIN_WITH_DIFFERENT_GIFS:
        _loadNewGifs();
        break;
      case GameOverChoice.CHOOSE_NEW_GIF_TYPE:
        Navigator.pop(context);
    }
  }

  void _loadNewGifs() {
    setState(() => _game = null);
    _offset++;
    _fetchGifs();
  }

  _fetchGifs() {
    _gifs = gif_api.get(widget.gifQuery, _offset);
  }

  void _initializeGame() async {
    List<GifCard> cards = await _gifs;
    _game = GifCardCollection(cards);
    _game.revealAll();
    setState(() {});
    Timer(Duration(seconds: 2), () {
      setState(() => _game.hideAll());
      _hidingPendingCards = false;
    });
  }
}

enum GameOverChoice {
  PLAY_AGAIN_WITH_SAME_GIFS,
  PLAY_AGAIN_WITH_DIFFERENT_GIFS,
  CHOOSE_NEW_GIF_TYPE
}

Future<GameOverChoice> showGameOverDialog(BuildContext context) async {
  return await showDialog<GameOverChoice>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('You won! What now?'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(
                    context, GameOverChoice.PLAY_AGAIN_WITH_SAME_GIFS);
              },
              child: const Text('Play again with same gifs'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(
                    context, GameOverChoice.PLAY_AGAIN_WITH_DIFFERENT_GIFS);
              },
              child: const Text('Play again with more gifs'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, GameOverChoice.CHOOSE_NEW_GIF_TYPE);
              },
              child: const Text('Choose new kind of gif'),
            ),
          ],
        );
      });
}

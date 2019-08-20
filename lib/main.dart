import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gif_memory/static_card_factory.dart';

import 'card_game.dart';

void main() => runApp(MyApp());

const GAME_DIMENSION = 4;
const DELAY_BEFORE_HIDING = Duration(seconds: 1);
const APP_TITLE = "Memory game";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MemoryGame(),
    );
  }
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  CardGame game = CardGame(new StaticImageCardFactory(GAME_DIMENSION));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: GridView.count(
        crossAxisCount: GAME_DIMENSION,
        children: _buildGrid(),
      ),
    );
  }

  _buildGrid() {
    return List.generate(game.cards.length, (index) {
      return Center(
          child: FlatButton(
              padding: EdgeInsets.symmetric(),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () => setState(() {
                    _revealAt(index);
                  }),
              child: game.isRevealedAt(index)
                  ? Text(game.faceAt(index))
                  : Container(color: Colors.black)));
    });
  }

  _revealAt(int index) async {
    setState(() => game.revealAt(index));
    if (game.shouldHideCards()) {
      Timer(DELAY_BEFORE_HIDING, () => setState(game.hideAndClearPending));
    } else if (game.shouldClearPending()) {
      setState(game.clearPending);
    }
    if (game.isOver()) {
      GameOverChoice choice = await showGameOverDialog(context);
      handleGameOverChoice(choice);
    }
  }

  void handleGameOverChoice(GameOverChoice choice) {
    switch (choice) {
      case GameOverChoice.PLAY_AGAIN_WITH_SAME_GIFS:
        game.reset();
        break;
      case GameOverChoice.PLAY_AGAIN_WITH_DIFFERENT_GIFS:
        game.loadNewGifs();
        break;
      case GameOverChoice.CHOOSE_NEW_GIF_TYPE:
      // Go back to gif choosing menu
    }
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
              child: const Text('Play again with new gifs'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, GameOverChoice.CHOOSE_NEW_GIF_TYPE);
              },
              child: const Text('Choose new gif type'),
            ),
          ],
        );
      });
}

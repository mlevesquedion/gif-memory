import 'package:flutter/material.dart';
import 'package:gif_memory/static_card_factory.dart';

import 'card_game.dart';

void main() => runApp(MyApp());

const GAME_DIMENSION = 4;
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
          child: MaterialButton(
              onPressed: () => setState(() {
                    game.revealAt(index);
                  }),
              child: Text(
                  game.isRevealedAt(index) ? game.faceAt(index) : "Hidden")));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:gif_memory/square_bit_matrix.dart';

void main() => runApp(MyApp());

const GRID_DIMENSION = 4;
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
  SquareBitMatrix _cards = SquareBitMatrix(GRID_DIMENSION);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_TITLE),
      ),
      body: GridView.count(
        crossAxisCount: GRID_DIMENSION,
        children: _buildGrid(),
      ),
    );
  }

  _buildGrid() {
    return List.generate(_cards.size(), (index) {
      return Center(
          child: MaterialButton(
              onPressed: () => _flipCard(index),
              child: Text(_cards.isSet(index) == true ? "True" : "False")));
    });
  }

  _flipCard(int index) {
    setState(() {
      _cards.flip(index);
    });
  }
}

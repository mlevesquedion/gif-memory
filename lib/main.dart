import 'package:flutter/material.dart';
import 'package:gif_memory/widgets/home_page.dart';

import 'constants.dart';

// TODO: verify card_collection tests
// TODO: fix bugs (card flipping)
// TODO: test widgets
// TODO: make it look good
// TODO: "preload" images so that they don't lag on first render
// TODO: (maybe) show cards at the start

main() {
  runApp(MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()));
}

import 'package:flutter/material.dart';
import 'package:gif_memory/widgets/home_page.dart';

import 'constants.dart';

// TODO: test widgets
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

import 'package:flutter/material.dart';
import 'package:gif_memory/widgets/home_page.dart';

import 'constants.dart';

// #TODO: "preload" images so that they don't lag on first render

main() {
  runApp(MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()));
}

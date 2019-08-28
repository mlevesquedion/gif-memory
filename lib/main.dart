import 'package:flash_memory/widgets/home_page.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

// TODO: show cards at the start

main() {
  runApp(MaterialApp(
      title: APP_TITLE,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage()));
}

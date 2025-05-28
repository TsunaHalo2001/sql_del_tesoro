import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:english_words/english_words.dart';

part 'myapp.dart';
part 'myappstate.dart';
part 'startmenu.dart';
part 'mapmenu.dart';
part 'myhomepage.dart';
part 'turtleintro.dart';
part 'turtleisland.dart';

void main() async {

  runApp(MyApp());
}
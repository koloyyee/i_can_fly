import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

/// flutter packages pub run build_runner build
/// flutter packages pub run build_runner watch
@Database(version: 1, entities:[])
abstract class AppDatabase extends FloorDatabase {

}

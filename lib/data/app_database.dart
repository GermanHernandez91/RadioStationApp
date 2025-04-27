import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

import './models/favorite_station.dart';
import './dao/favorite_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [FavoriteStation])
abstract class AppDatabase extends FloorDatabase {
  FavoriteDao get favoriteDao;
}
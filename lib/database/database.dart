import 'dart:async';

import 'package:floor/floor.dart';
import 'package:mcu_floor/dao/FeatureDao.dart';
import 'package:mcu_floor/dao/MovieDao.dart';
import 'package:mcu_floor/dao/SuperheroDao.dart';
import 'package:mcu_floor/entities/Feature.dart';
import 'package:mcu_floor/entities/Movie.dart';
import 'package:mcu_floor/entities/Superhero.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Movie, Superhero, Feature])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
  SuperheroDao get superheroDao;
  FeatureDao get featureDao;
}

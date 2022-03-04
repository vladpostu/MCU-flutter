import 'package:floor/floor.dart';

@entity
class Movie {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final int runningTime;
  final String releaseDate;
  final String director;

  Movie(
      {this.id,
      required this.name,
      required this.runningTime,
      required this.releaseDate,
      required this.director});
}

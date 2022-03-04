import 'package:floor/floor.dart';

@entity
class Superhero {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final String powers;
  final int powerRanking;

  Superhero(
      {this.id,
      required this.name,
      required this.powers,
      required this.powerRanking});
}

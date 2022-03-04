import 'package:floor/floor.dart';

@entity
class Feature {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int idMovie;
  final int idSuperhero;

  Feature({this.id, required this.idMovie, required this.idSuperhero});
}

import 'package:floor/floor.dart';
import 'package:mcu_floor/entities/Movie.dart';

@dao
abstract class MovieDao {
  @Query('SELECT * FROM Movie')
  Stream<List<Movie>> getAllMovies();

  @insert
  Future<void> insertMovie(Movie movie);

  @delete
  Future<void> deleteMovie(Movie movie);
}

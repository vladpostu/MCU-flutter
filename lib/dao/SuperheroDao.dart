import 'package:floor/floor.dart';
import 'package:mcu_floor/entities/Superhero.dart';

@dao
abstract class SuperheroDao {
  @Query('SELECT * FROM Superhero')
  Stream<List<Superhero>> getAllSuperheroes();

  @insert
  Future<void> insertSuperhero(Superhero superhero);

  @delete
  Future<void> deleteSuperhero(Superhero superhero);

  @Query('DELETE * FROM Superhero WHERE id = :id')
  Future<void> deleteSuperheroId(int id);
}

import 'package:floor/floor.dart';
import 'package:mcu_floor/entities/Feature.dart';

@dao
abstract class FeatureDao {
  @Query('SELECT * FROM Feature')
  Stream<List<Feature>> getAllFeatures();

  @Query('SELECT * FROM Feature WHERE idMovie = :id')
  Stream<List<Feature>> findFeatures(int id);

  @insert
  Future<void> insertFeature(Feature feature);

  @delete
  Future<void> deleteFeature(Feature feature);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

  SuperheroDao? _superheroDaoInstance;

  FeatureDao? _featureDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Movie` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `runningTime` INTEGER NOT NULL, `releaseDate` TEXT NOT NULL, `director` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Superhero` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `powers` TEXT NOT NULL, `powerRanking` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Feature` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `idMovie` INTEGER NOT NULL, `idSuperhero` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }

  @override
  SuperheroDao get superheroDao {
    return _superheroDaoInstance ??= _$SuperheroDao(database, changeListener);
  }

  @override
  FeatureDao get featureDao {
    return _featureDaoInstance ??= _$FeatureDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _movieInsertionAdapter = InsertionAdapter(
            database,
            'Movie',
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'runningTime': item.runningTime,
                  'releaseDate': item.releaseDate,
                  'director': item.director
                },
            changeListener),
        _movieDeletionAdapter = DeletionAdapter(
            database,
            'Movie',
            ['id'],
            (Movie item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'runningTime': item.runningTime,
                  'releaseDate': item.releaseDate,
                  'director': item.director
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movie> _movieInsertionAdapter;

  final DeletionAdapter<Movie> _movieDeletionAdapter;

  @override
  Stream<List<Movie>> getAllMovies() {
    return _queryAdapter.queryListStream('SELECT * FROM Movie',
        mapper: (Map<String, Object?> row) => Movie(
            id: row['id'] as int?,
            name: row['name'] as String,
            runningTime: row['runningTime'] as int,
            releaseDate: row['releaseDate'] as String,
            director: row['director'] as String),
        queryableName: 'Movie',
        isView: false);
  }

  @override
  Future<void> insertMovie(Movie movie) async {
    await _movieInsertionAdapter.insert(movie, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(Movie movie) async {
    await _movieDeletionAdapter.delete(movie);
  }
}

class _$SuperheroDao extends SuperheroDao {
  _$SuperheroDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _superheroInsertionAdapter = InsertionAdapter(
            database,
            'Superhero',
            (Superhero item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'powers': item.powers,
                  'powerRanking': item.powerRanking
                },
            changeListener),
        _superheroDeletionAdapter = DeletionAdapter(
            database,
            'Superhero',
            ['id'],
            (Superhero item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'powers': item.powers,
                  'powerRanking': item.powerRanking
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Superhero> _superheroInsertionAdapter;

  final DeletionAdapter<Superhero> _superheroDeletionAdapter;

  @override
  Stream<List<Superhero>> getAllSuperheroes() {
    return _queryAdapter.queryListStream('SELECT * FROM Superhero',
        mapper: (Map<String, Object?> row) => Superhero(
            id: row['id'] as int?,
            name: row['name'] as String,
            powers: row['powers'] as String,
            powerRanking: row['powerRanking'] as int),
        queryableName: 'Superhero',
        isView: false);
  }

  @override
  Future<void> deleteSuperheroId(int id) async {
    await _queryAdapter.queryNoReturn('DELETE * FROM Superhero WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertSuperhero(Superhero superhero) async {
    await _superheroInsertionAdapter.insert(
        superhero, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSuperhero(Superhero superhero) async {
    await _superheroDeletionAdapter.delete(superhero);
  }
}

class _$FeatureDao extends FeatureDao {
  _$FeatureDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _featureInsertionAdapter = InsertionAdapter(
            database,
            'Feature',
            (Feature item) => <String, Object?>{
                  'id': item.id,
                  'idMovie': item.idMovie,
                  'idSuperhero': item.idSuperhero
                },
            changeListener),
        _featureDeletionAdapter = DeletionAdapter(
            database,
            'Feature',
            ['id'],
            (Feature item) => <String, Object?>{
                  'id': item.id,
                  'idMovie': item.idMovie,
                  'idSuperhero': item.idSuperhero
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Feature> _featureInsertionAdapter;

  final DeletionAdapter<Feature> _featureDeletionAdapter;

  @override
  Stream<List<Feature>> getAllFeatures() {
    return _queryAdapter.queryListStream('SELECT * FROM Feature',
        mapper: (Map<String, Object?> row) => Feature(
            id: row['id'] as int?,
            idMovie: row['idMovie'] as int,
            idSuperhero: row['idSuperhero'] as int),
        queryableName: 'Feature',
        isView: false);
  }

  @override
  Stream<List<Feature>> findFeatures(int id) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Feature WHERE idMovie = ?1',
        mapper: (Map<String, Object?> row) => Feature(
            id: row['id'] as int?,
            idMovie: row['idMovie'] as int,
            idSuperhero: row['idSuperhero'] as int),
        arguments: [id],
        queryableName: 'Feature',
        isView: false);
  }

  @override
  Future<void> insertFeature(Feature feature) async {
    await _featureInsertionAdapter.insert(feature, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFeature(Feature feature) async {
    await _featureDeletionAdapter.delete(feature);
  }
}

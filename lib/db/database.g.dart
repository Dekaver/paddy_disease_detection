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

  PredictionDao? _predictionDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `Prediction` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `image` TEXT NOT NULL, `score` REAL NOT NULL, `time` REAL NOT NULL, `category` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PredictionDao get predictionDao {
    return _predictionDaoInstance ??= _$PredictionDao(database, changeListener);
  }
}

class _$PredictionDao extends PredictionDao {
  _$PredictionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _predictionInsertionAdapter = InsertionAdapter(
            database,
            'Prediction',
            (Prediction item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'score': item.score,
                  'time': item.time,
                  'category': item.category
                },
            changeListener),
        _predictionDeletionAdapter = DeletionAdapter(
            database,
            'Prediction',
            ['id'],
            (Prediction item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'image': item.image,
                  'score': item.score,
                  'time': item.time,
                  'category': item.category
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Prediction> _predictionInsertionAdapter;

  final DeletionAdapter<Prediction> _predictionDeletionAdapter;

  @override
  Future<List<Prediction>> findAllPredictions() async {
    return _queryAdapter.queryList('SELECT * FROM Prediction',
        mapper: (Map<String, Object?> row) => Prediction(
            row['id'] as int,
            row['name'] as String,
            row['image'] as String,
            row['score'] as double,
            row['time'] as double,
            row['category'] as String));
  }

  @override
  Stream<List<Prediction>> findAllPredictionsAsStream() {
    return _queryAdapter.queryListStream('SELECT * FROM Prediction',
        mapper: (Map<String, Object?> row) => Prediction(
            row['id'] as int,
            row['name'] as String,
            row['image'] as String,
            row['score'] as double,
            row['time'] as double,
            row['category'] as String),
        queryableName: 'Prediction',
        isView: false);
  }

  @override
  Stream<Prediction?> findPredictionById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Prediction WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Prediction(
            row['id'] as int,
            row['name'] as String,
            row['image'] as String,
            row['score'] as double,
            row['time'] as double,
            row['category'] as String),
        arguments: [id],
        queryableName: 'Prediction',
        isView: false);
  }

  @override
  Stream<List<Prediction>> findPredictionByCategory(String category) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Prediction WHERE category = ?1',
        mapper: (Map<String, Object?> row) => Prediction(
            row['id'] as int,
            row['name'] as String,
            row['image'] as String,
            row['score'] as double,
            row['time'] as double,
            row['category'] as String),
        arguments: [category],
        queryableName: 'Prediction',
        isView: false);
  }

  @override
  Future<void> insertPrediction(Prediction prediction) async {
    await _predictionInsertionAdapter.insert(
        prediction, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePrediction(Prediction prediction) async {
    await _predictionDeletionAdapter.delete(prediction);
  }
}

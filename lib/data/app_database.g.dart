// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  FavoriteDao? _favoriteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `FavoriteStation` (`url` TEXT NOT NULL, `name` TEXT NOT NULL, `favicon` TEXT NOT NULL, `country` TEXT NOT NULL, PRIMARY KEY (`url`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FavoriteDao get favoriteDao {
    return _favoriteDaoInstance ??= _$FavoriteDao(database, changeListener);
  }
}

class _$FavoriteDao extends FavoriteDao {
  _$FavoriteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _favoriteStationInsertionAdapter = InsertionAdapter(
            database,
            'FavoriteStation',
            (FavoriteStation item) => <String, Object?>{
                  'url': item.url,
                  'name': item.name,
                  'favicon': item.favicon,
                  'country': item.country
                },
            changeListener),
        _favoriteStationDeletionAdapter = DeletionAdapter(
            database,
            'FavoriteStation',
            ['url'],
            (FavoriteStation item) => <String, Object?>{
                  'url': item.url,
                  'name': item.name,
                  'favicon': item.favicon,
                  'country': item.country
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FavoriteStation> _favoriteStationInsertionAdapter;

  final DeletionAdapter<FavoriteStation> _favoriteStationDeletionAdapter;

  @override
  Future<List<FavoriteStation>> getAllFavorites() async {
    return _queryAdapter.queryList('SELECT * FROM FavoriteStation',
        mapper: (Map<String, Object?> row) => FavoriteStation(
            url: row['url'] as String,
            name: row['name'] as String,
            favicon: row['favicon'] as String,
            country: row['country'] as String));
  }

  @override
  Stream<List<FavoriteStation>> watchAllFavorites() {
    return _queryAdapter.queryListStream('SELECT * FROM FavoriteStation',
        mapper: (Map<String, Object?> row) => FavoriteStation(
            url: row['url'] as String,
            name: row['name'] as String,
            favicon: row['favicon'] as String,
            country: row['country'] as String),
        queryableName: 'FavoriteStation',
        isView: false);
  }

  @override
  Future<bool?> isFavorite(String url) async {
    return _queryAdapter.query(
        'SELECT EXISTS(SELECT 1 FROM FavoriteStation WHERE url = ?1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [url]);
  }

  @override
  Future<void> insertFavorite(FavoriteStation station) async {
    await _favoriteStationInsertionAdapter.insert(
        station, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteFavorite(FavoriteStation station) async {
    await _favoriteStationDeletionAdapter.delete(station);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

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

  FlightDao? _flightDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `flights` (`id` INTEGER NOT NULL, `airplane_id` INTEGER NOT NULL, `arrivalCity` TEXT NOT NULL, `departureCity` TEXT NOT NULL, `departureTime` INTEGER NOT NULL, `arrivalTime` INTEGER NOT NULL, FOREIGN KEY (`airplane_id`) REFERENCES `Airplane` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FlightDao get flightDao {
    return _flightDaoInstance ??= _$FlightDao(database, changeListener);
  }
}

class _$FlightDao extends FlightDao {
  _$FlightDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'flights',
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureTime':
                      _dateTimeConverter.encode(item.departureTime),
                  'arrivalTime': _dateTimeConverter.encode(item.arrivalTime)
                }),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureTime':
                      _dateTimeConverter.encode(item.departureTime),
                  'arrivalTime': _dateTimeConverter.encode(item.arrivalTime)
                }),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureTime':
                      _dateTimeConverter.encode(item.departureTime),
                  'arrivalTime': _dateTimeConverter.encode(item.arrivalTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> findAll() async {
    return _queryAdapter.queryList('select * from flights',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as int,
            airplaneId: row['airplane_id'] as int,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureTime:
                _dateTimeConverter.decode(row['departureTime'] as int),
            arrivalTime: _dateTimeConverter.decode(row['arrivalTime'] as int)));
  }

  @override
  Future<List<Flight>> findById(int id) async {
    return _queryAdapter.queryList('select * from flights where id = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as int,
            airplaneId: row['airplane_id'] as int,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureTime:
                _dateTimeConverter.decode(row['departureTime'] as int),
            arrivalTime: _dateTimeConverter.decode(row['arrivalTime'] as int)),
        arguments: [id]);
  }

  @override
  Future<void> createFlight(Flight newFlight) async {
    await _flightInsertionAdapter.insert(newFlight, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateFlight(Flight newFlight) {
    return _flightUpdateAdapter.updateAndReturnChangedRows(
        newFlight, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteFlight(Flight newFlight) {
    return _flightDeletionAdapter.deleteAndReturnChangedRows(newFlight);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

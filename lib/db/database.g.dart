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

  AirlineDao? _airlineDaoInstance;

  AirplaneDao? _airplaneDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `airlines` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `code` TEXT NOT NULL, `companyName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `airplanes` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `type` TEXT NOT NULL, `capacity` INTEGER NOT NULL, `maxSpeed` INTEGER NOT NULL, `maxRange` INTEGER NOT NULL, `manufacturer` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `flights` (`id` INTEGER NOT NULL, `airplane_id` INTEGER NOT NULL, `airline_id` INTEGER NOT NULL, `airlineCode` TEXT, `airplaneType` TEXT, `arrivalCity` TEXT NOT NULL, `departureCity` TEXT NOT NULL, `departureDateTime` INTEGER NOT NULL, `arrivalDateTime` INTEGER NOT NULL, FOREIGN KEY (`airplane_id`) REFERENCES `airplanes` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `birthday` INTEGER NOT NULL, `address` TEXT NOT NULL, `createdAt` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `staffs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `createdAt` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `airline_staff` (`airline_id` INTEGER NOT NULL, `staff_id` INTEGER NOT NULL, FOREIGN KEY (`airline_id`) REFERENCES `airlines` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`airline_id`, `staff_id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FlightDao get flightDao {
    return _flightDaoInstance ??= _$FlightDao(database, changeListener);
  }

  @override
  AirlineDao get airlineDao {
    return _airlineDaoInstance ??= _$AirlineDao(database, changeListener);
  }

  @override
  AirplaneDao get airplaneDao {
    return _airplaneDaoInstance ??= _$AirplaneDao(database, changeListener);
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
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                }),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                }),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Flight>> findAllFlights() async {
    return _queryAdapter.queryList('select * from flights',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as int,
            airplaneId: row['airplane_id'] as int,
            airlineId: row['airline_id'] as int,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as int),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as int),
            airlineCode: row['airlineCode'] as String?,
            airplaneType: row['airplaneType'] as String?));
  }

  @override
  Future<Flight?> findFlightById(int id) async {
    return _queryAdapter.query('select  * where f.id = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as int,
            airplaneId: row['airplane_id'] as int,
            airlineId: row['airline_id'] as int,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as int),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as int),
            airlineCode: row['airlineCode'] as String?,
            airplaneType: row['airplaneType'] as String?),
        arguments: [id]);
  }

  @override
  Future<Flight?> findFlightDetails(int id) async {
    return _queryAdapter.query(
        'select   f.id as flight_id,   f.departure_city,   f.arrival_city,   f.departure_datetime,   f.arrival_datetime,   f.airline_id,   f.airplane_id,   al.code as airline_code,   ap.manufacturer || \' \' || ap.type) as airplane_type   from flights f   join airplanes ap on f.airplane_id = ap.id   join airlines al on f.airline_id = al.id   where f.id = ?1',
        mapper: (Map<String, Object?> row) => Flight(id: row['id'] as int, airplaneId: row['airplane_id'] as int, airlineId: row['airline_id'] as int, arrivalCity: row['arrivalCity'] as String, departureCity: row['departureCity'] as String, departureDateTime: _dateTimeConverter.decode(row['departureDateTime'] as int), arrivalDateTime: _dateTimeConverter.decode(row['arrivalDateTime'] as int), airlineCode: row['airlineCode'] as String?, airplaneType: row['airplaneType'] as String?),
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

class _$AirlineDao extends AirlineDao {
  _$AirlineDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _flightInsertionAdapter = InsertionAdapter(
            database,
            'flights',
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                }),
        _flightUpdateAdapter = UpdateAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                }),
        _flightDeletionAdapter = DeletionAdapter(
            database,
            'flights',
            ['id'],
            (Flight item) => <String, Object?>{
                  'id': item.id,
                  'airplane_id': item.airplaneId,
                  'airline_id': item.airlineId,
                  'airlineCode': item.airlineCode,
                  'airplaneType': item.airplaneType,
                  'arrivalCity': item.arrivalCity,
                  'departureCity': item.departureCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Flight> _flightInsertionAdapter;

  final UpdateAdapter<Flight> _flightUpdateAdapter;

  final DeletionAdapter<Flight> _flightDeletionAdapter;

  @override
  Future<List<Airline>> findAllAirlines() async {
    return _queryAdapter.queryList('select * from airlines',
        mapper: (Map<String, Object?> row) => Airline(
            id: row['id'] as int,
            code: row['code'] as String,
            companyName: row['companyName'] as String));
  }

  @override
  Stream<Airline?> findAirlineById(int id) {
    return _queryAdapter.queryStream(
        'select   * from airlines    where id = ?1',
        mapper: (Map<String, Object?> row) => Airline(
            id: row['id'] as int,
            code: row['code'] as String,
            companyName: row['companyName'] as String),
        arguments: [id],
        queryableName: 'airlines',
        isView: false);
  }

  @override
  Future<void> createAirline(Flight newFlight) async {
    await _flightInsertionAdapter.insert(
        newFlight, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateAirline(Flight newFlight) {
    return _flightUpdateAdapter.updateAndReturnChangedRows(
        newFlight, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAirline(Flight newFlight) {
    return _flightDeletionAdapter.deleteAndReturnChangedRows(newFlight);
  }
}

class _$AirplaneDao extends AirplaneDao {
  _$AirplaneDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _airplaneInsertionAdapter = InsertionAdapter(
            database,
            'airplanes',
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'maxRange': item.maxRange,
                  'manufacturer': item.manufacturer
                }),
        _airplaneUpdateAdapter = UpdateAdapter(
            database,
            'airplanes',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'maxRange': item.maxRange,
                  'manufacturer': item.manufacturer
                }),
        _airplaneDeletionAdapter = DeletionAdapter(
            database,
            'airplanes',
            ['id'],
            (Airplane item) => <String, Object?>{
                  'id': item.id,
                  'type': item.type,
                  'capacity': item.capacity,
                  'maxSpeed': item.maxSpeed,
                  'maxRange': item.maxRange,
                  'manufacturer': item.manufacturer
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airplane> _airplaneInsertionAdapter;

  final UpdateAdapter<Airplane> _airplaneUpdateAdapter;

  final DeletionAdapter<Airplane> _airplaneDeletionAdapter;

  @override
  Future<List<Airplane>> findAllAirplanes() async {
    return _queryAdapter.queryList('select * from planes',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as int,
            type: row['type'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            maxRange: row['maxRange'] as int,
            manufacturer: row['manufacturer'] as String));
  }

  @override
  Future<Airplane?> findAirplaneById(int id) async {
    return _queryAdapter.query('select * from planes where id = ?1',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as int,
            type: row['type'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            maxRange: row['maxRange'] as int,
            manufacturer: row['manufacturer'] as String),
        arguments: [id]);
  }

  @override
  Future<void> createAirplane(Airplane newAirplane) async {
    await _airplaneInsertionAdapter.insert(
        newAirplane, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateAirplane(Airplane newAirplane) {
    return _airplaneUpdateAdapter.updateAndReturnChangedRows(
        newAirplane, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAirplane(Airplane newAirplane) {
    return _airplaneDeletionAdapter.deleteAndReturnChangedRows(newAirplane);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

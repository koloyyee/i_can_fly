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

  AdminDao? _adminDaoInstance;

  CustomerDao? _customerDaoInstance;

  ReservationDao? _reservationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `admins` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `createdAt` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `airlines` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `code` TEXT NOT NULL, `companyName` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `airplanes` (`id` INTEGER, `type` TEXT NOT NULL, `capacity` INTEGER NOT NULL, `maxSpeed` INTEGER NOT NULL, `maxRange` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `flights` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `airplaneType` TEXT, `arrivalCity` TEXT NOT NULL, `departureCity` TEXT NOT NULL, `departureDateTime` TEXT NOT NULL, `arrivalDateTime` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customers` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `birthday` TEXT NOT NULL, `address` TEXT NOT NULL, `createdAt` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `reservations` (`reservationId` INTEGER PRIMARY KEY AUTOINCREMENT, `customerId` INTEGER NOT NULL, `flightId` INTEGER NOT NULL, `departureCity` TEXT, `arrivalCity` TEXT, `departureDateTime` TEXT NOT NULL, `arrivalDateTime` TEXT NOT NULL, `customerName` TEXT, `reservationName` TEXT NOT NULL, FOREIGN KEY (`customerId`) REFERENCES `customers` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`flightId`) REFERENCES `flights` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');

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

  @override
  AdminDao get adminDao {
    return _adminDaoInstance ??= _$AdminDao(database, changeListener);
  }

  @override
  CustomerDao get customerDao {
    return _customerDaoInstance ??= _$CustomerDao(database, changeListener);
  }

  @override
  ReservationDao get reservationDao {
    return _reservationDaoInstance ??=
        _$ReservationDao(database, changeListener);
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
            id: row['id'] as int?,
            airplaneType: row['airplaneType'] as String?,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as String),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as String)));
  }

  @override
  Future<Flight?> findFlightById(int id) async {
    return _queryAdapter.query('select  * where f.id = ?1',
        mapper: (Map<String, Object?> row) => Flight(
            id: row['id'] as int?,
            airplaneType: row['airplaneType'] as String?,
            arrivalCity: row['arrivalCity'] as String,
            departureCity: row['departureCity'] as String,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as String),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as String)),
        arguments: [id]);
  }

  @override
  Future<List<String>> findAllAirplaneTypes() async {
    return _queryAdapter.queryList('select type as airplaneType from airplanes',
        mapper: (Map<String, Object?> row) => row.values.first as String);
  }

  @override
  Future<Flight?> findFlightDetails(int id) async {
    return _queryAdapter.query(
        'select   f.id as flight_id,   f.departure_city,   f.arrival_city,   f.departure_datetime,   f.arrival_datetime,   f.airline_id,   f.airplane_id,   al.code as airline_code,    ap.type as airplane_type   from flights f   join airplanes ap on f.airplane_id = ap.id   join airlines al on f.airline_id = al.id   where f.id = ?1',
        mapper: (Map<String, Object?> row) => Flight(id: row['id'] as int?, airplaneType: row['airplaneType'] as String?, arrivalCity: row['arrivalCity'] as String, departureCity: row['departureCity'] as String, departureDateTime: _dateTimeConverter.decode(row['departureDateTime'] as String), arrivalDateTime: _dateTimeConverter.decode(row['arrivalDateTime'] as String)),
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
        _airlineInsertionAdapter = InsertionAdapter(
            database,
            'airlines',
            (Airline item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'companyName': item.companyName
                },
            changeListener),
        _airlineUpdateAdapter = UpdateAdapter(
            database,
            'airlines',
            ['id'],
            (Airline item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'companyName': item.companyName
                },
            changeListener),
        _airlineDeletionAdapter = DeletionAdapter(
            database,
            'airlines',
            ['id'],
            (Airline item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'companyName': item.companyName
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airline> _airlineInsertionAdapter;

  final UpdateAdapter<Airline> _airlineUpdateAdapter;

  final DeletionAdapter<Airline> _airlineDeletionAdapter;

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
  Future<void> createAirline(Airline newAirline) async {
    await _airlineInsertionAdapter.insert(
        newAirline, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateAirline(Airline newAirline) {
    return _airlineUpdateAdapter.updateAndReturnChangedRows(
        newAirline, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAirline(Airline newAirline) {
    return _airlineDeletionAdapter.deleteAndReturnChangedRows(newAirline);
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
                  'maxRange': item.maxRange
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
                  'maxRange': item.maxRange
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
                  'maxRange': item.maxRange
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Airplane> _airplaneInsertionAdapter;

  final UpdateAdapter<Airplane> _airplaneUpdateAdapter;

  final DeletionAdapter<Airplane> _airplaneDeletionAdapter;

  @override
  Future<List<Airplane>> findAllAirplanes() async {
    return _queryAdapter.queryList('SELECT * FROM airplanes',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as int?,
            type: row['type'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            maxRange: row['maxRange'] as int));
  }

  @override
  Future<Airplane?> findAirplaneById(int id) async {
    return _queryAdapter.query('SELECT * FROM airplanes WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Airplane(
            id: row['id'] as int?,
            type: row['type'] as String,
            capacity: row['capacity'] as int,
            maxSpeed: row['maxSpeed'] as int,
            maxRange: row['maxRange'] as int),
        arguments: [id]);
  }

  @override
  Future<void> createAirplane(Airplane airplane) async {
    await _airplaneInsertionAdapter.insert(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAirplane(Airplane airplane) async {
    await _airplaneUpdateAdapter.update(airplane, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAirplane(Airplane airplane) async {
    await _airplaneDeletionAdapter.delete(airplane);
  }
}

class _$AdminDao extends AdminDao {
  _$AdminDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _adminInsertionAdapter = InsertionAdapter(
            database,
            'admins',
            (Admin item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'password': item.password,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _adminUpdateAdapter = UpdateAdapter(
            database,
            'admins',
            ['id'],
            (Admin item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'password': item.password,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _adminDeletionAdapter = DeletionAdapter(
            database,
            'admins',
            ['id'],
            (Admin item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'password': item.password,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Admin> _adminInsertionAdapter;

  final UpdateAdapter<Admin> _adminUpdateAdapter;

  final DeletionAdapter<Admin> _adminDeletionAdapter;

  @override
  Future<List<Admin>> findAllAdmins() async {
    return _queryAdapter.queryList('select * from admins',
        mapper: (Map<String, Object?> row) => Admin(
            id: row['id'] as int?,
            email: row['email'] as String,
            password: row['password'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)));
  }

  @override
  Future<Admin?> findAdminById(int id) async {
    return _queryAdapter.query('select  * from admins where id = ?1',
        mapper: (Map<String, Object?> row) => Admin(
            id: row['id'] as int?,
            email: row['email'] as String,
            password: row['password'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)),
        arguments: [id]);
  }

  @override
  Future<Admin?> findAdminByEmail(String email) async {
    return _queryAdapter.query('select * from admins where email = ?1',
        mapper: (Map<String, Object?> row) => Admin(
            id: row['id'] as int?,
            email: row['email'] as String,
            password: row['password'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)),
        arguments: [email]);
  }

  @override
  Future<void> createAdmin(Admin newAdmin) async {
    await _adminInsertionAdapter.insert(newAdmin, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateAdmin(Admin newAdmin) {
    return _adminUpdateAdapter.updateAndReturnChangedRows(
        newAdmin, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteAdmin(Admin newAdmin) {
    return _adminDeletionAdapter.deleteAndReturnChangedRows(newAdmin);
  }
}

class _$CustomerDao extends CustomerDao {
  _$CustomerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _customerInsertionAdapter = InsertionAdapter(
            database,
            'customers',
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'address': item.address,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _customerUpdateAdapter = UpdateAdapter(
            database,
            'customers',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'address': item.address,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                }),
        _customerDeletionAdapter = DeletionAdapter(
            database,
            'customers',
            ['id'],
            (Customer item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'email': item.email,
                  'password': item.password,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'birthday': _dateTimeConverter.encode(item.birthday),
                  'address': item.address,
                  'createdAt': _dateTimeConverter.encode(item.createdAt)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Customer> _customerInsertionAdapter;

  final UpdateAdapter<Customer> _customerUpdateAdapter;

  final DeletionAdapter<Customer> _customerDeletionAdapter;

  @override
  Future<List<Customer>> findAllCustomers() async {
    return _queryAdapter.queryList('SELECT * FROM customers',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            birthday: _dateTimeConverter.decode(row['birthday'] as String),
            address: row['address'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)));
  }

  @override
  Future<Customer?> findCustomerById(int id) async {
    return _queryAdapter.query('SELECT * FROM customers WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            birthday: _dateTimeConverter.decode(row['birthday'] as String),
            address: row['address'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)),
        arguments: [id]);
  }

  @override
  Future<Customer?> findCustomerByEmailAndPassword(
    String email,
    String password,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM customers WHERE email = ?1 AND password = ?2',
        mapper: (Map<String, Object?> row) => Customer(
            id: row['id'] as int?,
            name: row['name'] as String,
            email: row['email'] as String,
            password: row['password'] as String,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            birthday: _dateTimeConverter.decode(row['birthday'] as String),
            address: row['address'] as String,
            createdAt: _dateTimeConverter.decode(row['createdAt'] as String)),
        arguments: [email, password]);
  }

  @override
  Future<void> createCustomer(Customer newCustomer) async {
    await _customerInsertionAdapter.insert(
        newCustomer, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateCustomer(Customer newCustomer) {
    return _customerUpdateAdapter.updateAndReturnChangedRows(
        newCustomer, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCustomer(Customer newCustomer) async {
    await _customerDeletionAdapter.delete(newCustomer);
  }
}

class _$ReservationDao extends ReservationDao {
  _$ReservationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _reservationInsertionAdapter = InsertionAdapter(
            database,
            'reservations',
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'customerId': item.customerId,
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'arrivalCity': item.arrivalCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime),
                  'customerName': item.customerName,
                  'reservationName': item.reservationName
                }),
        _reservationUpdateAdapter = UpdateAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'customerId': item.customerId,
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'arrivalCity': item.arrivalCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime),
                  'customerName': item.customerName,
                  'reservationName': item.reservationName
                }),
        _reservationDeletionAdapter = DeletionAdapter(
            database,
            'reservations',
            ['reservationId'],
            (Reservation item) => <String, Object?>{
                  'reservationId': item.reservationId,
                  'customerId': item.customerId,
                  'flightId': item.flightId,
                  'departureCity': item.departureCity,
                  'arrivalCity': item.arrivalCity,
                  'departureDateTime':
                      _dateTimeConverter.encode(item.departureDateTime),
                  'arrivalDateTime':
                      _dateTimeConverter.encode(item.arrivalDateTime),
                  'customerName': item.customerName,
                  'reservationName': item.reservationName
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Reservation> _reservationInsertionAdapter;

  final UpdateAdapter<Reservation> _reservationUpdateAdapter;

  final DeletionAdapter<Reservation> _reservationDeletionAdapter;

  @override
  Future<List<Reservation>> findAllReservations() async {
    return _queryAdapter.queryList('SELECT * FROM reservations',
        mapper: (Map<String, Object?> row) => Reservation(
            reservationId: row['reservationId'] as int?,
            customerId: row['customerId'] as int,
            flightId: row['flightId'] as int,
            departureCity: row['departureCity'] as String?,
            arrivalCity: row['arrivalCity'] as String?,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as String),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as String),
            customerName: row['customerName'] as String?,
            reservationName: row['reservationName'] as String));
  }

  @override
  Future<Reservation?> findReservationById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM reservations WHERE reservationId = ?1',
        mapper: (Map<String, Object?> row) => Reservation(
            reservationId: row['reservationId'] as int?,
            customerId: row['customerId'] as int,
            flightId: row['flightId'] as int,
            departureCity: row['departureCity'] as String?,
            arrivalCity: row['arrivalCity'] as String?,
            departureDateTime:
                _dateTimeConverter.decode(row['departureDateTime'] as String),
            arrivalDateTime:
                _dateTimeConverter.decode(row['arrivalDateTime'] as String),
            customerName: row['customerName'] as String?,
            reservationName: row['reservationName'] as String),
        arguments: [id]);
  }

  @override
  Future<Reservation?> findDetailedReservationById(int id) async {
    return _queryAdapter.query(
        'select        r.reservationId,        c.name AS customerName,       f.departureCity,        f.arrivalCity,        f.departureDateTime,        f.arrivalDateTime       from reservations r       join flights f on r.flightId  = f.id        join customers c on r.customerId = c.id        where r.reservationId = ?1',
        mapper: (Map<String, Object?> row) => Reservation(reservationId: row['reservationId'] as int?, customerId: row['customerId'] as int, flightId: row['flightId'] as int, departureCity: row['departureCity'] as String?, arrivalCity: row['arrivalCity'] as String?, departureDateTime: _dateTimeConverter.decode(row['departureDateTime'] as String), arrivalDateTime: _dateTimeConverter.decode(row['arrivalDateTime'] as String), customerName: row['customerName'] as String?, reservationName: row['reservationName'] as String),
        arguments: [id]);
  }

  @override
  Future<void> createReservation(Reservation newReservation) async {
    await _reservationInsertionAdapter.insert(
        newReservation, OnConflictStrategy.rollback);
  }

  @override
  Future<int> updateReservation(Reservation newReservation) {
    return _reservationUpdateAdapter.updateAndReturnChangedRows(
        newReservation, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteReservation(Reservation newReservation) async {
    await _reservationDeletionAdapter.delete(newReservation);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();

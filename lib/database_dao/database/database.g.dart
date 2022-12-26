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

  CoordDao? _coordDaoInstance;

  WeatherDataDao? _weatherDataDaoInstance;

  CloudsDao? _cloudsDaoInstance;

  WindDao? _windDaoInstance;

  MainDao? _mainDaoInstance;

  SysDao? _sysDaoInstance;

  WeatherDao? _weatherDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `coordData` (`db_id` INTEGER PRIMARY KEY AUTOINCREMENT, `lan` REAL, `lat` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `weatherData` (`db_id` INTEGER PRIMARY KEY AUTOINCREMENT, `base` TEXT, `visibility` INTEGER, `dt` INTEGER, `timezone` INTEGER, `id` INTEGER, `name` TEXT, `cod` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cloudsData` (`db_id` INTEGER PRIMARY KEY AUTOINCREMENT, `all` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `windData` (`db_id` INTEGER PRIMARY KEY AUTOINCREMENT, `speed` REAL, `deg` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `mainData` (`db_id` INTEGER PRIMARY KEY AUTOINCREMENT, `temp` REAL, `feels_like` REAL, `temp_min` REAL, `temp_max` REAL, `pressure` INTEGER, `humidity` INTEGER, `sea_level` INTEGER, `grnd_level` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `sysData` (`type` INTEGER, `id` INTEGER, `country` TEXT, `sunrise` INTEGER, `sunset` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `weatherTable` (`id` INTEGER, `main` TEXT, `description` TEXT, `icon` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CoordDao get coordDao {
    return _coordDaoInstance ??= _$CoordDao(database, changeListener);
  }

  @override
  WeatherDataDao get weatherDataDao {
    return _weatherDataDaoInstance ??=
        _$WeatherDataDao(database, changeListener);
  }

  @override
  CloudsDao get cloudsDao {
    return _cloudsDaoInstance ??= _$CloudsDao(database, changeListener);
  }

  @override
  WindDao get windDao {
    return _windDaoInstance ??= _$WindDao(database, changeListener);
  }

  @override
  MainDao get mainDao {
    return _mainDaoInstance ??= _$MainDao(database, changeListener);
  }

  @override
  SysDao get sysDao {
    return _sysDaoInstance ??= _$SysDao(database, changeListener);
  }

  @override
  WeatherDao get weatherDao {
    return _weatherDaoInstance ??= _$WeatherDao(database, changeListener);
  }
}

class _$CoordDao extends CoordDao {
  _$CoordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _coordInsertionAdapter = InsertionAdapter(
            database,
            'coordData',
            (Coord item) => <String, Object?>{
                  'db_id': item.db_id,
                  'lan': item.lan,
                  'lat': item.lat
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Coord> _coordInsertionAdapter;

  @override
  Future<Coord?> findCoordData() async {
    return _queryAdapter.query('SELECT * FROM coordData',
        mapper: (Map<String, Object?> row) =>
            Coord(lan: row['lan'] as double?, lat: row['lat'] as double?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from coordData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM coordData');
  }

  @override
  Future<void> insertCoordData(Coord coord) async {
    await _coordInsertionAdapter.insert(coord, OnConflictStrategy.abort);
  }
}

class _$WeatherDataDao extends WeatherDataDao {
  _$WeatherDataDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _weatherDataInsertionAdapter = InsertionAdapter(
            database,
            'weatherData',
            (WeatherData item) => <String, Object?>{
                  'db_id': item.db_id,
                  'base': item.base,
                  'visibility': item.visibility,
                  'dt': item.dt,
                  'timezone': item.timezone,
                  'id': item.id,
                  'name': item.name,
                  'cod': item.cod
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WeatherData> _weatherDataInsertionAdapter;

  @override
  Future<WeatherData?> findWeatherData() async {
    return _queryAdapter.query('SELECT * FROM weatherData',
        mapper: (Map<String, Object?> row) => WeatherData(
            base: row['base'] as String?,
            visibility: row['visibility'] as int?,
            dt: row['dt'] as int?,
            timezone: row['timezone'] as int?,
            id: row['id'] as int?,
            name: row['name'] as String?,
            cod: row['cod'] as int?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from weatherData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM weatherData');
  }

  @override
  Future<void> insertWeatherData(WeatherData weatherData) async {
    await _weatherDataInsertionAdapter.insert(
        weatherData, OnConflictStrategy.abort);
  }
}

class _$CloudsDao extends CloudsDao {
  _$CloudsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _cloudsInsertionAdapter = InsertionAdapter(
            database,
            'cloudsData',
            (Clouds item) =>
                <String, Object?>{'db_id': item.db_id, 'all': item.all});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Clouds> _cloudsInsertionAdapter;

  @override
  Future<Clouds?> findCloudsData() async {
    return _queryAdapter.query('SELECT * FROM cloudsData',
        mapper: (Map<String, Object?> row) => Clouds(all: row['all'] as int?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from cloudsData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM cloudsData');
  }

  @override
  Future<void> insertCloudsData(Clouds clouds) async {
    await _cloudsInsertionAdapter.insert(clouds, OnConflictStrategy.abort);
  }
}

class _$WindDao extends WindDao {
  _$WindDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _windInsertionAdapter = InsertionAdapter(
            database,
            'windData',
            (Wind item) => <String, Object?>{
                  'db_id': item.db_id,
                  'speed': item.speed,
                  'deg': item.deg
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Wind> _windInsertionAdapter;

  @override
  Future<Wind?> findWindData() async {
    return _queryAdapter.query('SELECT * FROM windData',
        mapper: (Map<String, Object?> row) =>
            Wind(speed: row['speed'] as double?, deg: row['deg'] as double?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from windData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM windData');
  }

  @override
  Future<void> insertWindData(Wind wind) async {
    await _windInsertionAdapter.insert(wind, OnConflictStrategy.abort);
  }
}

class _$MainDao extends MainDao {
  _$MainDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mainClassInsertionAdapter = InsertionAdapter(
            database,
            'mainData',
            (MainClass item) => <String, Object?>{
                  'db_id': item.db_id,
                  'temp': item.temp,
                  'feels_like': item.feels_like,
                  'temp_min': item.temp_min,
                  'temp_max': item.temp_max,
                  'pressure': item.pressure,
                  'humidity': item.humidity,
                  'sea_level': item.sea_level,
                  'grnd_level': item.grnd_level
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MainClass> _mainClassInsertionAdapter;

  @override
  Future<MainClass?> findMainData() async {
    return _queryAdapter.query('SELECT * FROM mainData',
        mapper: (Map<String, Object?> row) => MainClass(
            temp: row['temp'] as double?,
            feels_like: row['feels_like'] as double?,
            temp_min: row['temp_min'] as double?,
            temp_max: row['temp_max'] as double?,
            pressure: row['pressure'] as int?,
            humidity: row['humidity'] as int?,
            sea_level: row['sea_level'] as int?,
            grnd_level: row['grnd_level'] as int?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from mainData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM mainData');
  }

  @override
  Future<void> insertMainData(MainClass mainClass) async {
    await _mainClassInsertionAdapter.insert(
        mainClass, OnConflictStrategy.abort);
  }
}

class _$SysDao extends SysDao {
  _$SysDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sysInsertionAdapter = InsertionAdapter(
            database,
            'sysData',
            (Sys item) => <String, Object?>{
                  'type': item.type,
                  'id': item.id,
                  'country': item.country,
                  'sunrise': item.sunrise,
                  'sunset': item.sunset
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Sys> _sysInsertionAdapter;

  @override
  Future<Sys?> findSysData() async {
    return _queryAdapter.query('SELECT * FROM sysData',
        mapper: (Map<String, Object?> row) => Sys(
            type: row['type'] as int?,
            id: row['id'] as int?,
            country: row['country'] as String?,
            sunrise: row['sunrise'] as int?,
            sunset: row['sunset'] as int?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from sysData');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM sysData');
  }

  @override
  Future<void> insertSysData(Sys sys) async {
    await _sysInsertionAdapter.insert(sys, OnConflictStrategy.abort);
  }
}

class _$WeatherDao extends WeatherDao {
  _$WeatherDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _weatherInsertionAdapter = InsertionAdapter(
            database,
            'weatherTable',
            (Weather item) => <String, Object?>{
                  'id': item.id,
                  'main': item.main,
                  'description': item.description,
                  'icon': item.icon
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Weather> _weatherInsertionAdapter;

  @override
  Future<Weather?> findWeather() async {
    return _queryAdapter.query('SELECT * FROM weatherTable',
        mapper: (Map<String, Object?> row) => Weather(
            id: row['id'] as int?,
            main: row['main'] as String?,
            description: row['description'] as String?,
            icon: row['icon'] as String?));
  }

  @override
  Future<void> deleteTasks() async {
    await _queryAdapter.queryNoReturn('delete from weatherTable');
  }

  @override
  Future<int?> tableIsEmpty() async {
    await _queryAdapter.queryNoReturn('SELECT COUNT(*) FROM weatherTable');
  }

  @override
  Future<void> insertWeather(Weather weather) async {
    await _weatherInsertionAdapter.insert(weather, OnConflictStrategy.abort);
  }
}

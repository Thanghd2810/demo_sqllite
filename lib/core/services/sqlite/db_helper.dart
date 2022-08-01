///
/// Create / delete / modify DB with SQLite
///
part of local_database;

final dbHelperProvider = Provider(
  (_) => DBHelper(),
);

class DBHelper {
  late Database _db;

  Future<void> ensureInitialized() async {
    /// Specify the file to save the database
    final String path = join(await getDatabasesPath(), kDataBaseName);

    /// Migration
    final config = MigrationConfig(
      initializationScript: kInitializeTable,
      migrationScripts: kMigrations,
    );

    /// Open database
    _db = await openDatabaseWithMigration(path, config);
  }

  Future<void> dispose() async {
    await _db.close();
  }

  /// Delete the database
  Future<void> deleteDB() async {
    final String path = join(await getDatabasesPath(), kDataBaseName);
    await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    try {
      return _db.rawQuery(sql, arguments);
    } catch (e) {
      throw DBException("Failed to raw query.");
    }
  }

  Future<int> rawInsert(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    try {
      return _db.rawInsert(sql, arguments);
    } catch (e) {
      throw DBException("Failed to raw insert.");
    }
  }

  Future<int> rawUpdate(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    try {
      return _db.rawUpdate(sql, arguments);
    } catch (e) {
      throw DBException("Failed to raw update.");
    }
  }

  Future<int> rawDelete(
    String sql, [
    List<dynamic> ?arguments,
  ]) async {
    try {
      return _db.rawDelete(sql, arguments);
    } catch (e) {
      throw DBException("Failed to raw delete.");
    }
  }

  Future<List<Map<String, dynamic>>> query(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<dynamic>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      return await _db.query(
        tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
    } catch (e) {
      throw DBException("Failed to query.");
    }
  }

  Future<int> insert(String tableName, Map<String, dynamic> values) async {
    try {
      return await _db.insert(tableName, values);
    } catch (e) {
      throw DBException("Failed to create data.");
    }
  }

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    try {
      return await _db.query(tableName);
    } catch (e) {
      throw DBException("Failed to get all data.");
    }
  }

  Future<int> update(
    String tableName,
    Map<String, dynamic> values, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      return await _db.update(
        tableName,
        values,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      throw DBException("Failed to update data.");
    }
  }

  Future<int> delete(
    String tableName, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    try {
      return await _db.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      );
    } catch (e) {
      throw DBException("Failed to delete data.");
    }
  }
}

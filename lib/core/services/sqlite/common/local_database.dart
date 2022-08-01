part of local_database;

abstract class LocalDataBase {
  LocalDataBase(this.dbHelper) : super();

  final DBHelper dbHelper;
}

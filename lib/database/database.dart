import 'dart:io';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper{
  DataBaseHelper();

  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';
  static const columnId = 'id';
  static const columnName = 'name';
  static const columnDescription = 'description';
  static const columnPrice = 'price';
  static const columnMinQty = 'minQty';
  static const columnMaxQty = 'maxQty';
  static const columnServiceId = 'serviceId';

  DataBaseHelper._privateConstructor();

  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  _initiateDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ('
        '$columnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
        '$columnName TEXT,'
        '$columnDescription TEXT,'
        '$columnPrice INTEGER,'
        '$columnMinQty INTEGER,'
        '$columnMaxQty INTEGER,'
        '$columnServiceId INTEGER'
        ')'
    );
  }

  Future<bool> saveServiceIemToDatabase(ServicesDataBaseModel saveToDataBaseModel) async {
    var dbServicesItem = await database;
    await dbServicesItem.insert (
        table, saveToDataBaseModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<ServicesDataBaseModel>> getAllServiceItems() async {
    var dbServicesItem = await database;
    List listMap = await dbServicesItem
        .rawQuery('SELECT * FROM my_table');
    var listServicesDatabase = <ServicesDataBaseModel>[];
    for (Map<String, dynamic> m in listMap) {
      listServicesDatabase.add(ServicesDataBaseModel.fromJson(m));
    }
    return listServicesDatabase;
  }
}
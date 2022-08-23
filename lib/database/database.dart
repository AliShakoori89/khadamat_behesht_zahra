import 'dart:io';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
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
  static const columnImagePath = 'imagePath';
  static const columnName = 'name';

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
        '$columnImagePath TEXT'
        ')'
    );
  }

  Future<bool> saveSarviceIemToDatabase(SaveToDataBaseModel saveToDataBaseModel) async {
    var dbServicesItem = await database;
    await dbServicesItem.insert (
        SaveToDataBaseModel.TABLENAME,saveToDataBaseModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<SaveToDataBaseModel>> getAllMedicines() async {
    print('111111');
    var dbServicesItem = await database;
    print('222222');
    var listMap = await dbServicesItem
        .rawQuery('SELECT * FROM my_table');
    print('33333');
    var listServicesDatabase = <SaveToDataBaseModel>[];
    print('444444');
    for (Map<String, dynamic> m in listMap) {
      listServicesDatabase.add(SaveToDataBaseModel.fromJson(m));
    }
    print('____________________________________________-');
    print(listServicesDatabase);
    return listServicesDatabase;
  }
}
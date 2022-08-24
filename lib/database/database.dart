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
  static const columnName = 'name';
  static const columnImagePath = 'imagePath';


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

  Future<bool> saveServiceIemToDatabase(ServicesDataBaseModel saveToDataBaseModel) async {
    var dbServicesItem = await database;
    await dbServicesItem.insert (
        table, saveToDataBaseModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<ServicesDataBaseModel>> getAllMedicines() async {
    print('111111');
    var dbServicesItem = await database;
    print('222222');
    List listMap = await dbServicesItem
        .rawQuery('SELECT * FROM my_table');
    print('33333');
    var listServicesDatabase = <ServicesDataBaseModel>[];
    print('444444');
    for (Map<String, dynamic> m in listMap) {
      listServicesDatabase.add(ServicesDataBaseModel.fromJson(m));
      print(m);
    }
    print('____________________________________________-');
    print(listServicesDatabase);
    return listServicesDatabase;
  }
}
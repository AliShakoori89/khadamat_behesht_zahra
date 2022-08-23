import 'dart:io';

import 'package:khadamat_behesht_zahra/database/database.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/network/api_base_helper.dart';

class ServicesRepository{

  final ApiBaseHelper _apiHelper = ApiBaseHelper();
  final DataBaseHelper helper= DataBaseHelper();

  Future<dynamic> getAllServicesItemRepository() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        var item = await _apiHelper.get('/Service/GetAllItems/');
        return item;
      }
    } on SocketException catch (_) {
      print('not connected');
      return await helper.getAllMedicines();
    }

  }

  Future<bool> saveServicesItemRepository(SaveToDataBaseModel saveToDataBaseModel) async {
    print('save save save save save save ');
    return await helper.saveSarviceIemToDatabase(saveToDataBaseModel);
  }

  // Future<List<SaveToDataBaseModel>> getAllServicesFromDatabaseRepo() async {
  //   return await helper.getAllMedicines();
  // }
}
import 'dart:io';

import 'package:khadamat_behesht_zahra/database/database.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_item_name_and_price_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/network/api_base_helper.dart';

class ServicesRepository{

  final ApiBaseHelper _apiHelper = ApiBaseHelper();
  final DataBaseHelper helper= DataBaseHelper();

  Future<dynamic> getAllServicesItemFromNetworkRepository() async {
    print('connected');
    var item = await _apiHelper.get('/Service/GetAllItems/');
    print(item);
    return item;
  }

  Future<List<ServicesDataBaseModel>> getAllServicesItemFromDatabaseRepository() async {
    var item = await helper.getAllServiceItems();
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^   '+item.toString());
    return item;
  }

  Future<bool> saveServicesItemRepository(ServicesDataBaseModel saveToDataBaseModel) async {
    return await helper.saveServiceIemToDatabase(saveToDataBaseModel);
  }

  Future<dynamic> getAllServiceItemImagesRepository(int serviceId) async{
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
    print('/Service/item/$serviceId/images');
    var item = await _apiHelper.get('/Service/item/$serviceId/images/');
    print('============================================== '+item.toString());
    return item;
  }

  Future<bool> saveServicesItemPriceRepository(SaveNameAndPriceModel saveNameAndPriceModel) async {
    return await helper.saveServiceIemPriceToDatabase(saveNameAndPriceModel);
  }

  Future<dynamic> getServiceItemPriceRepository(int serviceId) async{
    var item = await helper.getAllServiceItems();
    return item;
  }
}
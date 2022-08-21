import 'package:khadamat_behesht_zahra/network/api_base_helper.dart';

class AllServicesRepository{

  ApiBaseHelper _apiHelper = ApiBaseHelper();

  Future<dynamic> getAllServicesItemRepository() async {
    var weather = await _apiHelper.get('/Service/GetAllItems/');
    print('_________________________________________');
    return weather;
  }
}
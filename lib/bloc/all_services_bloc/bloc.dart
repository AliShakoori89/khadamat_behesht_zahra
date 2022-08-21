import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';
import 'package:http/http.dart' as http;

class AllServicesBloc extends Bloc<AllServicesItemEvent, AllServicesState>{

  AllServicesRepository allServicesRepository;

  AllServicesBloc(this.allServicesRepository) : super(GetAllServicesInitialState());

  @override
  Stream<AllServicesState> mapEventToState(AllServicesItemEvent event) async*{
    if(event is GetAllServicesItemEvent){
      yield GetAllServicesIsLoadingState(message: 'Loading products');
      final response = await allServicesRepository.getAllServicesItemRepository();
      print('responseeeeeeeeeeeeeeeeeeeeeeeeeeee    $response');
      if (response is http.Response) {
        print('responseeeeeeeeeeeeeeeeeeeeeeeeeeee    ${response.statusCode}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('5555555555555555555555555555555555');
          List<DataListModel>? allServicesItem =
              ServicesAllItemModel.fromJson(json.decode(response.body)).data;
          print('***************************$allServicesItem');
          yield GetAllServicesIsLoadedState(allServicesItem);
        } else {
          yield GetAllServicesIsNotLoadedState(error: response.body);
        }
      } else if (response is String) {
        yield GetAllServicesIsNotLoadedState(error: response);
      }
    }
  }
}
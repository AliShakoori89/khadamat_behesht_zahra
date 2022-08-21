import 'package:equatable/equatable.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';

class AllServicesState extends Equatable {
  @override

  List<Object> get props => throw[];
}


class GetAllServicesInitialState extends AllServicesState {}

class GetAllServicesIsLoadingState extends AllServicesState {
  late String message;

  GetAllServicesIsLoadingState({required String message});
}

class GetAllServicesIsLoadedState extends AllServicesState{

  final allServicesItem;

  GetAllServicesIsLoadedState(this.allServicesItem);

  List<DataListModel> get getAllServicesItem => allServicesItem;


  @override
  List<Object> get props => [allServicesItem];
}

class GetAllServicesIsNotLoadedState extends AllServicesState {
  late String error;

  GetAllServicesIsNotLoadedState({required String error});

}
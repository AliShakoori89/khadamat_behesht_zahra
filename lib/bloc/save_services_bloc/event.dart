import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';

abstract class ServiceEvent {
  const ServiceEvent();
}

class SaveAllServiceEvent extends ServiceEvent {
  final SaveToDataBaseModel service;

  SaveAllServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class FetchServicesItemFromDatabaseEvent extends ServiceEvent {}

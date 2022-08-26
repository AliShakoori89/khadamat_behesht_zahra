import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';

abstract class DatabaseEvent {
  const DatabaseEvent();
}

class SaveAllServiceEvent extends DatabaseEvent {
  final ServicesDataBaseModel service;

  SaveAllServiceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class FetchServicesItemFromDatabaseEvent extends DatabaseEvent {}

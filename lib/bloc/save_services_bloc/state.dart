import 'package:equatable/equatable.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';

enum ServicesStatus { initial, success, error, loading }

extension SaveServicesStatusX on ServicesStatus {
  bool get isInitial => this == ServicesStatus.initial;
  bool get isSuccess => this == ServicesStatus.success;
  bool get isError => this == ServicesStatus.error;
  bool get isLoading => this == ServicesStatus.loading;
}

class ServicesState extends Equatable {

  const ServicesState({
    this.status = ServicesStatus.initial,
  });

  final ServicesStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [status];

  ServicesState copyWith({
    ServicesStatus? status,
    List<SaveToDataBaseModel>? allServices,
  }) {
    return ServicesState(
      status: status ?? this.status
    );
  }
}
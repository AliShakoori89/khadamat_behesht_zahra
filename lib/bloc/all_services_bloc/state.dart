import 'package:equatable/equatable.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';

enum AllServicesStatus { initial, success, error, loading }

extension AllServicesStatusX on AllServicesStatus {
  bool get isInitial => this == AllServicesStatus.initial;
  bool get isSuccess => this == AllServicesStatus.success;
  bool get isError => this == AllServicesStatus.error;
  bool get isLoading => this == AllServicesStatus.loading;
}

class AllServicesState extends Equatable {

  const AllServicesState({
    this.status = AllServicesStatus.initial,
    List<DataListModel>? allServices,
  }): allServicesFromNetwork = allServices ?? const [];

  final AllServicesStatus status;
  final List<DataListModel> allServicesFromNetwork;

  @override
  // TODO: implement props
  List<Object> get props => [status, allServicesFromNetwork];

  AllServicesState copyWith({
    AllServicesStatus? status,
    List<DataListModel>? allServices
  }) {
    return AllServicesState(
      status: status ?? this.status,
      allServices: allServices ?? this.allServicesFromNetwork,
    );
  }
}
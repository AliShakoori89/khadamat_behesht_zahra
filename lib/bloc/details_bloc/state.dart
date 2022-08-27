import 'package:equatable/equatable.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/images_of_service_model.dart';

enum ServiceDetailsStatus { initial, success, error, loading }

extension ServicesStatusX on ServiceDetailsStatus {
  bool get isInitial => this == ServiceDetailsStatus.initial;
  bool get isSuccess => this == ServiceDetailsStatus.success;
  bool get isError => this == ServiceDetailsStatus.error;
  bool get isLoading => this == ServiceDetailsStatus.loading;
}

class ServiceDetailsState extends Equatable {

  const ServiceDetailsState({
    this.status = ServiceDetailsStatus.initial,
    List<DataListOfImagesModel>? serviceImages,
  }): allServiceImages = serviceImages ?? const [];

  final ServiceDetailsStatus status;
  final List<DataListOfImagesModel> allServiceImages;

  @override
  // TODO: implement props
  List<Object> get props => [status, allServiceImages];

  ServiceDetailsState copyWith({
    ServiceDetailsStatus? status,
    List<DataListOfImagesModel>? allServices
  }) {
    return ServiceDetailsState(
      status: status ?? this.status,
      serviceImages: allServices ?? allServiceImages,
    );
  }
}
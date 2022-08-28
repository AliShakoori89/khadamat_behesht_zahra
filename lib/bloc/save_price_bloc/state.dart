import 'package:equatable/equatable.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_item_name_and_price_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';

enum SaveServicePriceStatus { initial, success, error, loading }

extension SaveServicesStatusX on SaveServicePriceStatus {
  bool get isInitial => this == SaveServicePriceStatus.initial;
  bool get isSuccess => this == SaveServicePriceStatus.success;
  bool get isError => this == SaveServicePriceStatus.error;
  bool get isLoading => this == SaveServicePriceStatus.loading;
}

class SavePriceState extends Equatable {

  const SavePriceState({
    this.status = SaveServicePriceStatus.initial,
    List<SaveNameAndPriceModel>? servicePrice,
  }): servicePrice = servicePrice ?? const [];

  final SaveServicePriceStatus status;
  final List<SaveNameAndPriceModel> servicePrice;

  @override
  // TODO: implement props
  List<Object> get props => [status, servicePrice];

  SavePriceState copyWith({
    SaveServicePriceStatus? status,
    List<SaveNameAndPriceModel>? allServices,
  }) {
    return SavePriceState(
      status: status ?? this.status,
      servicePrice: allServices ?? servicePrice,
    );
  }
}
import 'package:khadamat_behesht_zahra/model/save_item_name_and_price_model.dart';

abstract class SavePriceEvent {
  const SavePriceEvent();
}

class SaveServicePriceEvent extends SavePriceEvent {
  final SaveNameAndPriceModel service;

  SaveServicePriceEvent(this.service);

  @override
  List<Object> get props => [service];
}

class FetchServicePriceFromDatabaseEvent extends SavePriceEvent {}

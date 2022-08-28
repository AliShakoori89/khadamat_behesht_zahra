import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/state.dart';
import 'package:khadamat_behesht_zahra/bloc/save_price_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/save_price_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/save_item_name_and_price_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';


class SavePriceBloc extends Bloc<SavePriceEvent, SavePriceState> {
  ServicesRepository allServicesRepository;

  SavePriceBloc(this.allServicesRepository) : super(const SavePriceState()){
    on<SaveServicePriceEvent>(_mapSaveServicePriceEventToState);
    // on<FetchServicePriceFromDatabaseEvent>(_mapFetchServicesPriceFromDatabaseEventToState);
  }

  void _mapSaveServicePriceEventToState(
      SaveServicePriceEvent event, Emitter<SavePriceState> emit) async {

    try {
      emit(state.copyWith(status: SaveServicePriceStatus.loading));
      print('************************************    '+event.service.name.toString());
      await allServicesRepository.saveServicesItemPriceRepository(event.service);
      emit(
        state.copyWith(
          status: SaveServicePriceStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: SaveServicePriceStatus.error));
    }
  }

  // void _mapFetchServicesPriceFromDatabaseEventToState(
  //     FetchServicePriceFromDatabaseEvent event, Emitter<SavePriceState> emit) async {
  //   try {
  //     emit(state.copyWith(status: SaveServicePriceStatus.loading));
  //     List<SaveNameAndPriceModel> allServices = await allServicesRepository.getServiceItemPriceRepository(serviceId);
  //     emit(
  //       state.copyWith(
  //         status: SaveServicePriceStatus.success,
  //         allServices: allServices
  //       ),
  //     );
  //   } catch (error) {
  //     emit(state.copyWith(status: SaveServicePriceStatus.error));
  //   }
  // }
}
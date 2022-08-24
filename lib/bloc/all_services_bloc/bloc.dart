import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';


class AllServicesBloc extends Bloc<AllServicesItemEvent, AllServicesState> {
  ServicesRepository allServicesRepository;

  AllServicesBloc(this.allServicesRepository) : super(const AllServicesState()){
    on<GetAllServicesItemEvent>(_mapGetAllServicesItemEventToState);
  }

  void _mapGetAllServicesItemEventToState(
      GetAllServicesItemEvent event, Emitter<AllServicesState> emit) async {

    // try {
    //   final result = await InternetAddress.lookup('google.com');
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //     print('connected');
        final response = await allServicesRepository.getAllServicesItemFromNetworkRepository();

        try {
          emit(state.copyWith(status: AllServicesStatus.loading));
          List<DataListModel>? allServicesItem =
              ServicesAllItemModel.fromJson(json.decode(response.body)).data;
          emit(
            state.copyWith(
              status: AllServicesStatus.success,
              allServices: allServicesItem,
            ),
          );
        } catch (error) {
          emit(state.copyWith(status: AllServicesStatus.error));
        }
      }
    // } on SocketException catch (_) {
    //   print('not connected');
    //   try {
    //     emit(state.copyWith(status: AllServicesStatus.loading));
    //     List<DataListModel>? allServicesItem =
    //     await allServicesRepository.getAllServicesItemFromDatabaseRepository();
    //     emit(
    //       state.copyWith(
    //         status: AllServicesStatus.success,
    //         allServices: allServicesItem,
    //       ),
    //     );
    //   } catch (error) {
    //     emit(state.copyWith(status: AllServicesStatus.error));
    //   }
    // }
  // }
}
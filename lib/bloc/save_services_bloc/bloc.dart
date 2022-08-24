import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/all_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/save_services_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/get_all_services_Items_model.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';


class SaveServicesBloc extends Bloc<ServiceEvent, ServicesState> {
  ServicesRepository allServicesRepository;

  SaveServicesBloc(this.allServicesRepository) : super(const ServicesState()){
    on<SaveAllServiceEvent>(_mapSaveServiceEventToState);
    on<FetchServicesItemFromDatabaseEvent>(_mapFetchServicesItemFromDatabaseEventToState);
  }

  void _mapSaveServiceEventToState(
      SaveAllServiceEvent event, Emitter<ServicesState> emit) async {

    try {
      emit(state.copyWith(status: ServicesStatus.loading));
      print('************************************    '+event.service.name.toString());
      await allServicesRepository.saveServicesItemRepository(event.service);
      emit(
        state.copyWith(
          status: ServicesStatus.success,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ServicesStatus.error));
    }
  }

  void _mapFetchServicesItemFromDatabaseEventToState(
      FetchServicesItemFromDatabaseEvent event, Emitter<ServicesState> emit) async {
    try {
      emit(state.copyWith(status: ServicesStatus.loading));
      List<ServicesDataBaseModel> allServices = await allServicesRepository.getAllServicesItemFromDatabaseRepository();
      emit(
        state.copyWith(
          status: ServicesStatus.success,
          allServices: allServices
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ServicesStatus.error));
    }
  }
}
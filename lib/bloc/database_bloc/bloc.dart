import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/database_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/save_to_database_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';


class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  ServicesRepository allServicesRepository;

  DatabaseBloc(this.allServicesRepository) : super(const DatabaseState()){
    on<SaveAllServiceEvent>(_mapSaveServiceEventToState);
    on<FetchServicesItemFromDatabaseEvent>(_mapFetchServicesItemFromDatabaseEventToState);
  }

  void _mapSaveServiceEventToState(
      SaveAllServiceEvent event, Emitter<DatabaseState> emit) async {

    try {
      emit(state.copyWith(status: ServicesStatus.loading));
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
      FetchServicesItemFromDatabaseEvent event, Emitter<DatabaseState> emit) async {
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
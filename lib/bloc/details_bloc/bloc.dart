import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khadamat_behesht_zahra/bloc/details_bloc/event.dart';
import 'package:khadamat_behesht_zahra/bloc/details_bloc/state.dart';
import 'package:khadamat_behesht_zahra/model/images_of_service_model.dart';
import 'package:khadamat_behesht_zahra/repository/all_services_repository.dart';

class ServiceDetailsBloc extends Bloc<ServiceDetailsEvent, ServiceDetailsState> {
  ServicesRepository allServicesRepository;

  ServiceDetailsBloc(this.allServicesRepository) : super(const ServiceDetailsState()) {
    on<GetServiceAllImagesEvent>(_mapGetServiceItemImagesEventToState);
  }

  void _mapGetServiceItemImagesEventToState(
      GetServiceAllImagesEvent event, Emitter<ServiceDetailsState> emit) async {
    try {
      emit(state.copyWith(status: ServiceDetailsStatus.loading));
      List<DataListOfImagesModel> servicesItemImages =
      await allServicesRepository.getAllServiceItemImagesRepository(event.serviceId);
      print('servicesItemImages servicesItemImages   '+ servicesItemImages.toString());
      emit(
        state.copyWith(
          status: ServiceDetailsStatus.success,
          allServices: servicesItemImages,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: ServiceDetailsStatus.error));
    }
  }
}

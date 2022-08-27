
abstract class ServiceDetailsEvent {
  const ServiceDetailsEvent();
}

class GetServiceAllImagesEvent extends ServiceDetailsEvent {

  final int serviceId;
  const GetServiceAllImagesEvent(this.serviceId);

  @override
  List<Object> get props => [serviceId];
}


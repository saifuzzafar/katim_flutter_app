import 'package:katim_app/core/usecases/base_usecases.dart';
import 'package:katim_app/domain/entities/event_list_response.dart';
import 'package:katim_app/domain/repository/events_repository.dart';

class GetEventsUseCase
    extends BaseUseCase<Future<EventListResponse>, EventListParams> {
  EventRepository eventRepository;
  GetEventsUseCase(this.eventRepository);

  @override
  Future<EventListResponse> execute(params) {
    return eventRepository.getEventList(
        pageNumber: params.pageNumber, query: params.query);
  }
}

class EventListParams {
  final int? pageNumber;
  final String? query;

  const EventListParams({this.pageNumber, this.query});
}

import 'package:katim_app/data/datasource/local/local_datasource.dart';
import 'package:katim_app/data/datasource/remote/remote_datasource.dart';
import 'package:katim_app/data/entity/remote/event_list_entity.dart';
import 'package:katim_app/domain/entities/event_list_response.dart';
import 'package:katim_app/domain/repository/events_repository.dart';

class EventsRepositoryImp extends EventRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  EventsRepositoryImp(this.remoteDataSource, this.localDataSource);

  @override
  Future<EventListResponse> getEventList(
      {int? pageNumber, String? query}) async {
    try {
      EventListEntity eventList = await remoteDataSource.getEventList(
          query: query, pageNumber: pageNumber);
      return EventListResponse(
          events: eventList.events
              ?.map((e) => EventsResponse(
                  title: e.title,
                  datetimeTbd: e.datetimeTbd,
                  datetimeUtc: e.datetimeUtc,
                  id: e.id,
                  shortTitle: e.shortTitle,
                  type: e.type,
                  performerResponse:
                      PerformerResponse(imageUrl: e.performers?.first.image),
                  venueResponse:
                      VenueResponse(displayLocation: e.venue?.displayLocation)))
              .toList(),
          meta: MetaResponse(
              page: eventList.meta?.page,
              perPage: eventList.meta?.page,
              took: eventList.meta?.took,
              total: eventList.meta?.total));
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<String> fetchFromFavourites(int id) {
    return localDataSource.fetchFromFavourites(id);
  }

  @override
  Future<bool> removeFromFavourites(int id) {
    return localDataSource.removeFromFavourites(id);
  }

  @override
  Future<bool> saveToFavourites(int id) {
    return localDataSource.saveToFavourites(id);
  }

  @override
  bool checkIfFavourite(int id) {
    return localDataSource.checkIfFavourites(id);
  }
}

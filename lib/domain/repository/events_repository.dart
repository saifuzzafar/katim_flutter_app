import 'package:katim_app/domain/entities/event_list_response.dart';

abstract class EventRepository {
  Future<EventListResponse> getEventList({int? pageNumber, String? query});

  Future<bool> saveToFavourites(int id);
  Future<bool> removeFromFavourites(int id);
  Future<String> fetchFromFavourites(int id);
  bool checkIfFavourite(int id);
}

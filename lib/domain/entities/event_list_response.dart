import 'package:equatable/equatable.dart';

class EventListResponse extends Equatable {
  List<EventsResponse>? events;
  MetaResponse? meta;
  EventListResponse({this.events, this.meta});

  @override
  List<Object?> get props => [events];
}

class EventsResponse extends Equatable {
  String? type;
  int? id;
  String? datetimeUtc;
  bool? datetimeTbd;
  String? shortTitle;
  String? title;
  PerformerResponse? performerResponse;
  VenueResponse? venueResponse;

  EventsResponse(
      {this.id,
      this.type,
      this.title,
      this.datetimeTbd,
      this.datetimeUtc,
      this.shortTitle,
      this.performerResponse,
      this.venueResponse});

  @override
  List<Object?> get props => [id, title];
}

class MetaResponse {
  int? total;
  int? took;
  int? page;
  int? perPage;
  MetaResponse({this.page, this.perPage, this.took, this.total});
}

class PerformerResponse {
  String? imageUrl;
  PerformerResponse({this.imageUrl});
}

class VenueResponse {
  String? displayLocation;

  VenueResponse({this.displayLocation});
}

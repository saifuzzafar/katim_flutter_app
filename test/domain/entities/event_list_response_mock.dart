import 'package:katim_app/domain/entities/event_list_response.dart';

EventListResponse eventListResponseMock =
    EventListResponse(events: eventsResponseMock, meta: metaResponse);

List<EventsResponse> eventsResponseMock = [
  EventsResponse(
      id: 123433,
      type: "sports",
      shortTitle: "This is short title",
      title: "this is title",
      datetimeUtc: "10.45 PM",
      datetimeTbd: false),
  EventsResponse(
      id: 145433,
      type: "Entertainment",
      shortTitle: "This is short title 2",
      title: "this is title 2",
      datetimeUtc: "10.55 PM",
      datetimeTbd: true),
];

MetaResponse metaResponse =
    MetaResponse(total: 23, took: 45, perPage: 3, page: 1);

import 'package:flutter_test/flutter_test.dart';
import 'package:katim_app/domain/entities/event_list_response.dart';
import 'package:katim_app/domain/repository/events_repository.dart';
import 'package:katim_app/domain/usecases/get_events_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../entities/event_list_response_mock.dart';
import 'get_event_list_test.mocks.dart';

@GenerateMocks([EventRepository])
void main() {
  late GetEventsUseCase useCase;
  late MockEventRepository mockEventRepository;

  setUp(() {
    mockEventRepository = MockEventRepository();
    useCase = GetEventsUseCase(mockEventRepository);
  });

  EventListResponse eventListResponse = eventListResponseMock;

  test("Should get list of events", () async {
    //arrange
    when(mockEventRepository.getEventList())
        .thenAnswer((realInvocation) async => eventListResponse);
    //act
    final result = await useCase.execute(const EventListParams());

    expect(result, eventListResponseMock);
    //verify

    verify(mockEventRepository.getEventList());
    verifyNoMoreInteractions(mockEventRepository);
  });
}

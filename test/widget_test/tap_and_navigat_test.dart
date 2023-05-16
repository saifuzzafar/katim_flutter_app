import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katim_app/domain/repository/events_repository.dart';
import 'package:katim_app/domain/usecases/check_if_favourite_usecase.dart';
import 'package:katim_app/domain/usecases/get_events_usecase.dart';
import 'package:katim_app/presentation/features/event_details/event_details_page.dart';
import 'package:katim_app/presentation/features/event_details/event_details_view.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_list_mobile_view.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../domain/entities/event_list_response_mock.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockGetEventsUseCase extends Mock implements GetEventsUseCase {}

class MockEventRepository extends Mock implements EventRepository {}

class MockCheckIfFavouriteUseCase extends Mock
    implements CheckIfFavouriteUseCase {}

void main() {
  late MockGetEventsUseCase mockGetEventsUseCase;
  late MockCheckIfFavouriteUseCase mockCheckIfFavouriteUseCase;
  late EventListDataProvider eventListDataProvider;
  late MockEventRepository mockEventRepository;

  setUpAll(() {
    mockGetEventsUseCase = MockGetEventsUseCase();
    mockCheckIfFavouriteUseCase = MockCheckIfFavouriteUseCase();
    mockEventRepository = MockEventRepository();

    eventListDataProvider = EventListDataProvider(
        GetEventsUseCase(mockEventRepository),
        CheckIfFavouriteUseCase(mockEventRepository));

    // when(mockEventRepository.getEventList())
    //     .thenAnswer((realInvocation) => Future.value(eventListResponseMock));
    // when(eventListDataProvider.getEventList(onComplete: (data) => true))
    //     .thenAnswer((realInvocation) => eventsResponseMock);
  });

  //
  // context.read<GetEventsUseCase>(),
  // context.read<CheckIfFavouriteUseCase>()),

  testWidgets("Tap on item and navigate to next screen",
      (WidgetTester tester) async {
    when(eventListDataProvider.getEventList(onComplete: (data) => true))
        .thenAnswer((realInvocation) => eventsResponseMock);
    final mockObserver = MockNavigatorObserver();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => eventListDataProvider)
        ],
        child: Builder(
          builder: (_) => MaterialApp(
            home: const EventListView(),
            navigatorObservers: [mockObserver],
          ),
        ),
      ),
    );

    // when(eventListDataProvider.getEventList(onComplete: (data) {
    //   return true;
    // })).thenAnswer((realInvocation) => Future.value(eventsResponseMock));
    // await tester.pump();

    // expect(find.byKey(const Key('event_list_view')), findsOneWidget);
    // expect(find.byKey(const Key('load_shimmer')), findsOneWidget);
    // expect(find.byKey(const Key('no_data')), findsOneWidget);

    await tester.pump();

    expect(find.byKey(const Key('load_shimmer')), findsOneWidget);
    await Future.delayed(Duration(seconds: 10));
    await tester.pump();
    expect(find.byKey(const Key('ListViewKey')), findsOneWidget);
    final item = find.byKey(const ValueKey('item_1'));
    final eventRoute = MaterialPageRoute(
        builder: (_) => EventDetailsView(arguments: EventDetailsArguments(23)));

    expect(item, findsOneWidget);
    await tester.tap(item);
    await tester.pumpAndSettle();

    /// Verify that a push event happened
    verify(mockObserver.didPush(eventRoute, any));

    /// You'd also want to be sure that your page is now
    /// present in the screen
    expect(find.byKey(const Key('EventDetailsViewKey')), findsOneWidget);
  });
}

import 'package:flutter/cupertino.dart';
import 'package:katim_app/core/navigation/route_paths.dart';
import 'package:katim_app/presentation/features/event_details/event_details_page.dart';
import 'package:katim_app/presentation/features/event_list/event_list_mobile_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.eventDetails:
        return CupertinoPageRoute(
          builder: (context) => EventDetailsPage(
              arguments: settings.arguments as EventDetailsArguments),
          settings: const RouteSettings(name: RoutePaths.eventDetails),
        );

      default:
        return CupertinoPageRoute(
          builder: (context) => const EventListView(),
        );
    }
  }
}

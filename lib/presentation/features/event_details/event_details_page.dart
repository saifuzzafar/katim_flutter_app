import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:katim_app/presentation/features/event_details/event_details_view.dart';
import 'package:katim_app/presentation/features/event_details/event_details_web_view.dart';
import 'package:katim_app/presentation/molecules/device_detector_widget.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsArguments arguments;
  EventDetailsPage({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return DeviceDetectorWidget(
          webSiteView: () => EventDetailsWebView(arguments: arguments),
          tabletView: () => EventDetailsView(
                arguments: arguments,
              ),
          phoneView: () => EventDetailsView(
                arguments: arguments,
              ));
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      return EventDetailsWebView(arguments: arguments);
    } else {
      return EventDetailsView(
        arguments: arguments,
      );
    }
  }
}

class EventDetailsArguments {
  final int index;
  EventDetailsArguments(this.index);
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_list_mobile_view.dart';
import 'package:katim_app/presentation/features/event_list/event_list_web_view.dart';
import 'package:katim_app/presentation/molecules/device_detector_widget.dart';
import 'package:provider/provider.dart';

class EventListingPage extends StatefulWidget {
  const EventListingPage({Key? key}) : super(key: key);

  @override
  State<EventListingPage> createState() => _EventListingPageState();
}

class _EventListingPageState extends State<EventListingPage> {
  @override
  void initState() {
    super.initState();
    final event = Provider.of<EventListDataProvider>(context, listen: false);
    event.getEventList(onComplete: (val) {});
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return DeviceDetectorWidget(
          webSiteView: () => const EventListWebView(
                title: "Flutter Web",
              ),
          tabletView: () => const EventListView(),
          phoneView: () => const EventListView());
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      return const EventListWebView(
        title: "MacOS",
      );
    } else {
      return const EventListView();
    }
  }
}

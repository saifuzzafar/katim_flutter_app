import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_list_mobile_view.dart';
import 'package:katim_app/presentation/features/event_list/event_list_web_view.dart';
import 'package:katim_app/presentation/molecules/device_detector_widget.dart';
import 'package:katim_app/utils/ui_utils.dart';
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
    setUp();
  }

  setUp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventListDataProvider>(context, listen: false).getEventList(
        onComplete: (status) {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return DeviceDetectorWidget(
          webSiteView: () => const EventListWebView(
                title: "Flutter Web",
              ),
          tabletView: () => const EventListMobileView(),
          phoneView: () => const EventListMobileView());
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      if (UIUtils.isWeb(context)) {
        return const EventListWebView(
          title: "MacOS",
        );
      } else {
        return const EventListMobileView();
      }
    } else {
      return const EventListMobileView();
    }
  }
}

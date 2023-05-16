import 'package:flutter/material.dart';
import 'package:katim_app/presentation/features/event_details/event_details_page.dart';
import 'package:katim_app/presentation/features/event_details/favorite_widget/favorite_view.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/molecules/custom_divider.dart';
import 'package:katim_app/utils/app_utils.dart';
import 'package:katim_app/utils/screen_dimensions.dart';
import 'package:provider/provider.dart';

class EventDetailsWebView extends StatelessWidget {
  EventDetailsArguments arguments;
  EventDetailsWebView({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            const CustomDivider(
              pLeft: 10,
              pRight: 10,
            ),
            _buildBody(context)
          ],
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    final eventData =
        Provider.of<EventListDataProvider>(context, listen: false);
    final event = eventData.eventList[arguments.index];
    final title = event.title;
    return Container(
      height: 80,
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
          ),
          event.id == null
              ? const SizedBox.shrink()
              : FavoriteView(id: event.id!),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
    final eventData =
        Provider.of<EventListDataProvider>(context, listen: false);
    final event = eventData.eventList[arguments.index];
    final imageUrl = event.performerResponse?.imageUrl;
    final location = event.venueResponse?.displayLocation;
    final dateTime = event.datetimeUtc;
    final title = event.title;
    final shortTitle = event.shortTitle;

    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(50),

              // width: ScreenDimension.getDimensions(context).width * 0.50,
              child: imageUrl == null
                  ? const SizedBox.shrink()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: SizedBox(
                        width:
                            ScreenDimension.getDimensions(context).width - 20,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
          ),
          Expanded(
            child: Container(
              width: ScreenDimension.getDimensions(context).width * 0.50,
              margin: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  title == null
                      ? const SizedBox.shrink()
                      : Text(title,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w800)),
                  const SizedBox(
                    height: 20,
                  ),
                  dateTime == null
                      ? const SizedBox.shrink()
                      : Text(AppUtils.getFormattedDataAndTime(dateTime),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w800)),
                  const SizedBox(
                    height: 10,
                  ),
                  location == null
                      ? const SizedBox.shrink()
                      : Text(location,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

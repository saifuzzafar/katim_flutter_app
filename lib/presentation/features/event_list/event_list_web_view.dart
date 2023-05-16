import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:katim_app/core/navigation/route_paths.dart';
import 'package:katim_app/presentation/features/event_details/event_details_page.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/widget/event_grid_item.dart';
import 'package:katim_app/presentation/features/event_list/widget/search_text_field.dart';
import 'package:katim_app/presentation/molecules/list_shim.dart';
import 'package:katim_app/presentation/molecules/smart_bottom_refresher.dart';
import 'package:katim_app/utils/app_constants.dart';
import 'package:provider/provider.dart';

class EventListWebView extends StatelessWidget {
  final String? title;
  const EventListWebView({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [_buildTitle(), _buildSearchBar(context), _buildBody()],
        ),
      ),
    );
  }

  _buildTitle() {
    return title == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: TextStyle(fontSize: 16),
            ));
  }

  _buildSearchBar(BuildContext context) {
    final eventDataProvider =
        Provider.of<EventListDataProvider>(context, listen: false);

    return Container(
      //     color: AppConstants.searchBarColor,
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: AppConstants.searchBarColor,
      ),
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchTextField(
                controller: eventDataProvider.textController,
                onChanged: (String value) {
                  // Handle the text field value change here
                  EasyDebounce.debounce(
                      'my-debouncer',
                      const Duration(milliseconds: 400),
                      () =>
                          eventDataProvider.getEventList(onComplete: (val) {}));
                },
              ),
            ),
          ),
          Container(
              color: AppConstants.searchBarColor,
              child: MaterialButton(
                onPressed: () {},
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ))
        ],
      ),
    );
  }

  _buildBody() {
    return Expanded(
      child: Consumer<EventListDataProvider>(
        builder: (context, value, child) {
          final eventList = value.eventList;
          return value.loading
              ? const ListShim()
              : eventList.isEmpty
                  ? const Center(
                      child: Text(
                      "No data found",
                      style: TextStyle(fontSize: 18),
                    ))
                  : Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 30, right: 30),
                      child: SmartBottomRefresher().buildLoader(
                        context: context,
                        refreshController: value.webRefreshController,
                        onLoading: () {
                          value.pageNumberForApi += 1;
                          value.getEventList(
                              isPagination: true,
                              onComplete: (val) {
                                value.webRefreshController.loadComplete();
                              });
                        },
                        child: GridView.builder(
                          itemCount:
                              eventList.length, //added one for add banner
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            crossAxisSpacing: 40.0,
                            mainAxisSpacing: 50.0,
                          ),
                          itemBuilder: (context, index) {
                            final event = eventList[index];
                            final favStatus =
                                value.checkFavorite(eventList[index].id);
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RoutePaths.eventDetails,
                                    arguments: EventDetailsArguments(index));
                              },
                              child: EventGridItem(
                                title: event.title,
                                imageUrl: event.performerResponse?.imageUrl,
                                dateTime: event.datetimeUtc,
                                location: event.venueResponse?.displayLocation,
                                isFavorite: favStatus,
                              ),
                            );
                          },
                        ),
                      ),
                    );
        },
      ),
    );
  }
}

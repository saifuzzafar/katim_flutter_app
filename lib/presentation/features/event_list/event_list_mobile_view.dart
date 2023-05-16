import 'dart:core';
import 'dart:io';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:katim_app/core/navigation/route_paths.dart';
import 'package:katim_app/presentation/features/event_details/event_details_page.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/widget/event_list_item.dart';
import 'package:katim_app/presentation/features/event_list/widget/search_text_field.dart';
import 'package:katim_app/presentation/molecules/custom_divider.dart';
import 'package:katim_app/presentation/molecules/list_shim.dart';
import 'package:katim_app/presentation/molecules/smart_bottom_refresher.dart';
import 'package:katim_app/utils/app_constants.dart';
import 'package:katim_app/utils/ui_utils.dart';
import 'package:provider/provider.dart';

class EventListMobileView extends StatelessWidget {
  const EventListMobileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('event_list_view'),
      appBar: const AppBar(),
      body: SafeArea(
        child: Column(
          children: [_buildSearchBar(context), _buildBody()],
        ),
      ),
    );
  }

  _buildSearchBar(BuildContext context) {
    final eventDataProvider =
        Provider.of<EventListDataProvider>(context, listen: false);

    return Container(
      color: AppConstants.searchBarColor,
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
                      'my-debouncer', const Duration(milliseconds: 400), () {
                    if (Platform.isAndroid || Platform.isIOS) {
                      Future.delayed(const Duration(seconds: 500), () {
                        UIUtils.hideKeyboard();
                      });
                    }

                    eventDataProvider.pageNumberForApi = 1;
                    eventDataProvider.getEventList(onComplete: (val) {});
                  });
                },
              ),
            ),
          ),
          Container(
              color: AppConstants.searchBarColor,
              child: MaterialButton(
                onPressed: () {
                  eventDataProvider.textController.clear();
                  eventDataProvider.pageNumberForApi = 1;
                  eventDataProvider.getEventList(onComplete: (val) {});
                },
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
              ? const ListShim(
                  key: Key('load_shimmer'),
                )
              : eventList.isEmpty
                  ? const Center(
                      key: Key('no_data'),
                      child: Text(
                        "No data found",
                        style: TextStyle(fontSize: 18),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(top: 15, right: 15),
                      child: SmartBottomRefresher().buildLoader(
                        context: context,
                        refreshController: value.mobileRefreshController,
                        onLoading: () {
                          value.pageNumberForApi += 1;
                          value.getEventList(
                              isPagination: true,
                              onComplete: (val) {
                                value.mobileRefreshController.loadComplete();
                              });
                        },
                        child: ListView.builder(
                          key: const Key('ListViewKey'),
                          itemCount: eventList.length,
                          itemBuilder: (context, index) {
                            final event = eventList[index];
                            final favStatus =
                                value.checkFavorite(eventList[index].id);
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutePaths.eventDetails,
                                        arguments:
                                            EventDetailsArguments(index));
                                  },
                                  child: EventListItem(
                                    key: Key("item_$index"),
                                    title: event.title,
                                    imageUrl: event.performerResponse?.imageUrl,
                                    dateTime: event.datetimeUtc,
                                    location:
                                        event.venueResponse?.displayLocation,
                                    isFavorite: favStatus,
                                  ),
                                ),
                                const CustomDivider(),
                              ],
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

class AppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.searchBarColor,
    );
  }

  @override
  Size get preferredSize => const Size(0.0, 0.0);
}

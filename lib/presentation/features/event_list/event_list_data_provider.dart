import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:katim_app/domain/entities/event_list_response.dart';
import 'package:katim_app/domain/usecases/check_if_favourite_usecase.dart';
import 'package:katim_app/domain/usecases/get_events_usecase.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventListDataProvider with ChangeNotifier {
  final GetEventsUseCase getEventsUseCase;
  final CheckIfFavouriteUseCase checkIfFavouriteUseCase;
  EventListDataProvider(this.getEventsUseCase, this.checkIfFavouriteUseCase);

  List<EventsResponse> eventList = [];
  bool loading = false;

  RefreshController mobileRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController tabletRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController webRefreshController =
      RefreshController(initialRefresh: false);

  TextEditingController textController = TextEditingController();

  int pageNumberForApi = 1;

  getEventList(
      {int? pageNumber,
      bool isPagination = false,
      required Function(bool status) onComplete}) async {
    loading = true;
    String queryForApi = textController.text;
    try {
      final EventListResponse response = await getEventsUseCase.execute(
          EventListParams(query: queryForApi, pageNumber: pageNumberForApi));
      if (response.events != null) {
        if (isPagination) {
          response.events!.isNotEmpty
              ? eventList.addAll(response.events!)
              : eventList = response.events!;
        } else {
          eventList = response.events ?? [];
        }
      }
      loading = false;

      onComplete(true);
      notifyListeners();
    } catch (e) {
      print('Exceptions for the api ${e.toString()}');
      onComplete(false);
      Fluttertoast.showToast(
        msg: "Something went wrong with app",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
      );
      throw Exception(e);
    }
  }

  bool checkFavorite(int? id) {
    if (id != null) {
      final status =
          checkIfFavouriteUseCase.execute(CheckIfFavouriteParams(id));
      return status;
    } else {
      return false;
    }
  }

  refreshEventsList() {
    notifyListeners();
  }
}

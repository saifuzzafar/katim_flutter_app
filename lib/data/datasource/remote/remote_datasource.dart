import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:katim_app/data/datasource/remote/api_helper.dart';
import 'package:katim_app/data/entity/remote/event_list_entity.dart';

class RemoteDataSource {
  final http.Client client;

  RemoteDataSource(this.client);

  Future<EventListEntity> getEventList(
      {int? pageNumber = 1, String? query}) async {
    int perPage = kIsWeb ? 30 : 15;
    String url = "/events/";
    final page = pageNumber ?? 1;
    if (query != null && query != '') {
      url = "/events?page=$page&per_page=$perPage&q=$query";
    } else {
      url = "/events?page=$page&per_page=$perPage";
    }

    final res = await ApiHelper.createDioGetRequest(url);
    final decodedJson = res.data; //jsonDecode(res.data);

    if (res.statusCode == 200 && decodedJson != null) {
      EventListEntity eventList = EventListEntity.fromJson(res.data);
      return eventList;
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
      );
      throw Exception("This need to be thrown");
    }
  }
}

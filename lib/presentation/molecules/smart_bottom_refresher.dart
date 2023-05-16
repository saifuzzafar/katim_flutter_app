import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartBottomRefresher {
  Widget buildLoader(
      {BuildContext? context,
      Widget? child,
      required RefreshController refreshController,
      Function()? onLoading}) {
    void _onRefresh() async {
      refreshController.refreshCompleted();
    }

    void _onLoading() async {
      onLoading!();
    }

    return SmartRefresher(
      controller: refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      enablePullDown: false,
      enablePullUp: true,
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        builder: (BuildContext context, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text("idle");
          } else if (mode == LoadStatus.loading) {
            body = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CupertinoActivityIndicator(),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Load more")
                ]);
          } else if (mode == LoadStatus.failed) {
            body = const Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = const Text("Load more");
          } else {
            body = const Text("No more Data");
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      child: child,
    );
  }
}

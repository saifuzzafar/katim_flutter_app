import 'package:flutter/material.dart';
import 'package:katim_app/utils/ui_utils.dart';
import 'package:shimmer/shimmer.dart';

class ListShim extends StatelessWidget {
  const ListShim({super.key});

  @override
  Widget build(BuildContext context) {
    return UIUtils.isWeb(context)
        ? Padding(
            padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 40.0,
                mainAxisSpacing: 50.0,
              ),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 30,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        height: 30,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,

                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 78,
                      height: 78,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        width: 78,
                        height: 78,
                        color: Colors.grey,
                      ),
                    )
                  ],
                  // width: 100,
                  // height: 90,
                  // color: Colors.grey,
                ),

                // child: Container(
                //   color: Colors.grey[400],
                //   height: 80,
                //   child: Container(
                //     height: 160,
                //     color: Colors.grey,
                //   ),
                // ),
              );
            },
          );
  }
}

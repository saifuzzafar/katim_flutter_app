import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListShim extends StatelessWidget {
  const ListShim({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            color: Colors.grey[400],
            height: 80,
            child: Container(
              height: 160,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}

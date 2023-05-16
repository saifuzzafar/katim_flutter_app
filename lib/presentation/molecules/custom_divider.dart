import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.width = 1,
    this.height = 25,
    this.color = Colors.grey,
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color? color;
  final double pLeft;
  final double pTop;
  final double pRight;
  final double pBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: pLeft, right: pRight),
      child: Divider(
        thickness: 1,
        height: height,
        color: color,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:katim_app/utils/app_constants.dart';
import 'package:katim_app/utils/assets_utils.dart';

class SearchTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String? titleForPlatform;

  const SearchTextField(
      {Key? key,
      this.onChanged,
      required this.controller,
      this.titleForPlatform})
      : super(key: key);

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  // final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: AppConstants.searchBarInnerColor,
      ),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: widget.titleForPlatform == "MacOS" ||
                      widget.titleForPlatform == "Flutter Web"
                  ? 5
                  : 2),
          enabledBorder: InputBorder.none, // Remove underline
          focusedBorder: InputBorder.none, // Remove underline
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          suffixIcon: GestureDetector(
            onTap: () {
              widget.controller.clear();
              if (widget.onChanged != null) {
                widget.onChanged!('');
              }
            },
            child: Container(
              margin:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Image.asset(
                AssetUtils.closeButton,
                height: 2,
                width: 2,
              ),
            ),
          ),

          hintText: 'Search',
          hintStyle: const TextStyle(color: Colors.white54),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //widget.controller.dispose();
    super.dispose();
  }
}

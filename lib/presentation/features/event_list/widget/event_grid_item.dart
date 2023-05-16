import 'package:flutter/material.dart';
import 'package:katim_app/utils/app_utils.dart';
import 'package:katim_app/utils/screen_dimensions.dart';

class EventGridItem extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? dateTime;
  final String? location;
  final bool? isFavorite;
  const EventGridItem(
      {Key? key,
      this.title,
      this.imageUrl,
      this.dateTime,
      this.location,
      this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            imageUrl == null
                ? const SizedBox.shrink()
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: ScreenDimension.getDimensions(context).width - 20,
                      child: Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            title == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        title ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 5,
            ),
            location == null
                ? const SizedBox.shrink()
                : Text(location!,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
            const SizedBox(
              height: 5,
            ),
            dateTime == null
                ? const SizedBox.shrink()
                : Text(AppUtils.getFormattedDataAndTime(dateTime!),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                        fontWeight: FontWeight.w400))
          ],
        ),
        isFavorite != null && isFavorite == true
            ? const Positioned(
                left: 0,
                top: 0,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 30,
                  shadows: <Shadow>[
                    Shadow(
                        color: Colors.white,
                        blurRadius: 1.0,
                        offset: Offset(1, 1))
                  ],
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }
}

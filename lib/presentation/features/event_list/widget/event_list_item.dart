import 'package:flutter/material.dart';
import 'package:katim_app/utils/app_utils.dart';

class EventListItem extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final String? dateTime;
  final String? location;
  final bool? isFavorite;
  const EventListItem(
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
        SizedBox(
          height: 90,
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl!,
                          height: 78,
                          width: 78,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
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
              )
            ],
          ),
        ),
        isFavorite != null && isFavorite == true
            ? const Positioned(
                left: 8,
                top: 0,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 22,
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

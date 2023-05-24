import 'package:flutter/material.dart';
import 'package:katim_app/presentation/features/event_details/favorite_widget/favorite_data_provider.dart';
import 'package:katim_app/presentation/features/event_list/event_list_data_provider.dart';
import 'package:provider/provider.dart';

class FavoriteView extends StatefulWidget {
  final int id;

  const FavoriteView({Key? key, required this.id}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoriteDataProvider>(context, listen: false)
          .checkIfFavorite(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteDataProvider>(
      builder: (context, value, child) {
        final favoriteStatus =
            Provider.of<FavoriteDataProvider>(context, listen: false);
        final icon = favoriteStatus.favoriteStatus
            ? Icons.favorite
            : Icons.favorite_border;

        return IconButton(
            onPressed: () {
              if (favoriteStatus.favoriteStatus) {
                //remove from fav
                value.removeFromFavorite(widget.id, context);
              } else {
                //add in fav
                value.addIntoFavorite(widget.id, context);
              }
              Provider.of<EventListDataProvider>(context, listen: false)
                  .refreshEventsList();
            },
            icon: Icon(
              icon,
              color: Colors.red,
              size: 30,
            ));
      },
    );
  }
}

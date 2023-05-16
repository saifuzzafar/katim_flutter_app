import 'package:flutter/material.dart';
import 'package:katim_app/domain/usecases/check_if_favourite_usecase.dart';
import 'package:katim_app/domain/usecases/remove_from_favourites_usecase.dart';
import 'package:katim_app/domain/usecases/save_to_favourites_usecase.dart';
import 'package:katim_app/presentation/molecules/custom_snack_bar.dart';

class FavoriteDataProvider with ChangeNotifier {
  final SaveToFavouritesUseCase saveToFavouritesUseCase;
  final RemoveFromFavouritesUseCase removeFromFavouritesUseCase;
  final CheckIfFavouriteUseCase checkIfFavouriteUseCase;

  FavoriteDataProvider(this.saveToFavouritesUseCase,
      this.removeFromFavouritesUseCase, this.checkIfFavouriteUseCase);

  bool _favoriteStatus = false;

  bool get favoriteStatus => _favoriteStatus;

  set favoriteStatus(bool value) {
    _favoriteStatus = value;
    notifyListeners();
  }

  //check if event is present in favorite or not
  checkIfFavorite(int id) {
    final check = checkIfFavouriteUseCase.execute(CheckIfFavouriteParams(id));
    favoriteStatus = check;
  }

  //mark event as favorite
  addIntoFavorite(int id, BuildContext context) async {
    final favAdd =
        await saveToFavouritesUseCase.execute(SaveToFavouritesParams(id));
    favoriteStatus = favAdd;
    final message = favAdd ? "Added successfully" : "Unable to add";
    if (context.mounted) {
      CustomSnackBar().showSnackBar(content: message, context: context);
    }
  }

  //remove event from favorite
  removeFromFavorite(int id, BuildContext context) async {
    final favRemove = await removeFromFavouritesUseCase
        .execute(RemoveFromFavouritesParams(id));
    //if got false then delete successfully
    favoriteStatus = favRemove;
    final message = favRemove ? "Unable to remove" : "Removed successfully";
    if (context.mounted) {
      CustomSnackBar().showSnackBar(content: message, context: context);
    }
  }
}

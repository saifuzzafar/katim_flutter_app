import 'package:hive_flutter/hive_flutter.dart';
import 'package:katim_app/data/datasource/local/db_constants.dart';

class LocalDataSource {
  final Box hiveBox;
  LocalDataSource(this.hiveBox);

  Future<bool> saveToFavourites(int id) async {
    final key = '${DbConstants.favorite}_$id';
    await hiveBox.put(key, id);
    return checkIfFavourites(id);
  }

  Future<bool> removeFromFavourites(int id) async {
    final key = '${DbConstants.favorite}_$id';
    await hiveBox.delete(key);
    return checkIfFavourites(id);
  }

  Future<String> fetchFromFavourites(int id) async {
    var box = await Hive.openBox(DbConstants.favoriteBox);
    final key = '${DbConstants.favorite}_$id';
    return await box.get(key);
  }

  bool checkIfFavourites(int id) {
    final key = '${DbConstants.favorite}_$id';
    return hiveBox.containsKey(key);
  }
}

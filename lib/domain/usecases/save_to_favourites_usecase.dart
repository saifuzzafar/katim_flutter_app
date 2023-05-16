import 'package:katim_app/core/usecases/base_usecases.dart';
import 'package:katim_app/domain/repository/events_repository.dart';

class SaveToFavouritesUseCase
    extends BaseUseCase<Future<bool>, SaveToFavouritesParams> {
  final EventRepository eventRepository;
  const SaveToFavouritesUseCase(this.eventRepository);

  @override
  Future<bool> execute(SaveToFavouritesParams params) async {
    return await eventRepository.saveToFavourites(params.id);
  }
}

class SaveToFavouritesParams {
  final int id;
  const SaveToFavouritesParams(
    this.id,
  );
}

import 'package:katim_app/core/usecases/base_usecases.dart';
import 'package:katim_app/domain/repository/events_repository.dart';

class RemoveFromFavouritesUseCase
    extends BaseUseCase<Future<bool>, RemoveFromFavouritesParams> {
  final EventRepository eventRepository;
  const RemoveFromFavouritesUseCase(this.eventRepository);

  @override
  Future<bool> execute(RemoveFromFavouritesParams params) async {
    return await eventRepository.removeFromFavourites(params.id);
  }
}

class RemoveFromFavouritesParams {
  final int id;
  const RemoveFromFavouritesParams(
    this.id,
  );
}

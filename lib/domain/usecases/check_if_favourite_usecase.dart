import 'package:katim_app/core/usecases/base_usecases.dart';
import 'package:katim_app/domain/repository/events_repository.dart';

class CheckIfFavouriteUseCase
    extends BaseUseCase<bool, CheckIfFavouriteParams> {
  final EventRepository eventRepository;
  const CheckIfFavouriteUseCase(this.eventRepository);

  @override
  bool execute(CheckIfFavouriteParams params) {
    return eventRepository.checkIfFavourite(params.id);
  }
}

class CheckIfFavouriteParams {
  final int id;
  const CheckIfFavouriteParams(
    this.id,
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:katim_app/domain/usecases/check_if_favourite_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chcek_if_favorite_test.mocks.dart';

// @GenerateMocks([EventRepository, MockCheckIfFavouriteUseCase])
@GenerateMocks([CheckIfFavouriteUseCase])
void main() {
  // late CheckIfFavouriteUseCase checkIfFavouriteUseCase;
  // late MockEventRepository mockEventRepository;

  late MockCheckIfFavouriteUseCase mockCheckIfFavouriteUseCase;

  setUpAll(() {
    mockCheckIfFavouriteUseCase = MockCheckIfFavouriteUseCase();
  });

  bool successValutype = true;
  test('success check for usecase', () async {
    when(mockCheckIfFavouriteUseCase.execute(const CheckIfFavouriteParams(23)))
        .thenAnswer((_) => successValutype);

    expect(successValutype, true);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';
import 'package:shop_ez/domain/usecases/remove_item.dart';

class MockShoppingListRepository extends Mock
    implements ShoppingListRepository {}

void main() {
  late RemoveItem usecase;
  late MockShoppingListRepository mockRepository;

  setUp(() {
    mockRepository = MockShoppingListRepository();
    usecase = RemoveItem(mockRepository);
  });

  const tItemId = '1';

  test('should remove item from the repository', () async {
    // arrange
    when(() => mockRepository.removeItem(tItemId))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tItemId);
    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.removeItem(tItemId)).called(1);
  });

  test('should return failure when removing item fails', () async {
    // arrange
    when(() => mockRepository.removeItem(tItemId)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed to remove item')));
    // act
    final result = await usecase(tItemId);
    // assert
    expect(result, const Left(DatabaseFailure('Failed to remove item')));
    verify(() => mockRepository.removeItem(tItemId)).called(1);
  });
}

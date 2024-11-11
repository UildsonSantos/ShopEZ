import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';
import 'package:shop_ez/domain/usecases/remove_item.dart';

/// Tests for the `RemoveItem` use case.
class MockShoppingListRepository extends Mock
    implements ShoppingListRepository {}

void main() {
  late RemoveItem usecase;
  late MockShoppingListRepository mockRepository;

  /// Initial setup for the tests.
  setUp(() {
    mockRepository = MockShoppingListRepository();
    usecase = RemoveItem(mockRepository);
  });

  /// Test item ID.
  const tItemId = '1';

  /// Tests if the item is removed from the repository successfully.
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

  /// Tests if the use case returns a failure when removing the item fails.
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

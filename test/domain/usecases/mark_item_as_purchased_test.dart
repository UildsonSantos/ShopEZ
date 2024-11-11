import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';
import 'package:shop_ez/domain/usecases/mark_item_as_purchased.dart';

/// Tests for the `MarkItemAsPurchased` use case.
class MockShoppingListRepository extends Mock
    implements ShoppingListRepository {}

void main() {
  late MarkItemAsPurchased usecase;
  late MockShoppingListRepository mockRepository;

  /// Initial setup for the tests.
  setUp(() {
    mockRepository = MockShoppingListRepository();
    usecase = MarkItemAsPurchased(mockRepository);
  });

  /// Test item ID.
  const tItemId = '1';

  /// Tests if the item is marked as purchased in the repository successfully.
  test('should mark item as purchased in the repository', () async {
    // arrange
    when(() => mockRepository.markItemAsPurchased(tItemId))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(tItemId);
    // assert
    expect(result, const Right(null));
    verify(() => mockRepository.markItemAsPurchased(tItemId));
  });

  /// Tests if the use case returns a failure when marking the item as purchased fails.
  test('should return failure when marking item as purchased fails', () async {
    // arrange
    when(() => mockRepository.markItemAsPurchased(tItemId)).thenAnswer(
        (_) async =>
            const Left(DatabaseFailure('Failed to mark item as purchased')));
    // act
    final result = await usecase(tItemId);
    // assert
    expect(result,
        const Left(DatabaseFailure('Failed to mark item as purchased')));
    verify(() => mockRepository.markItemAsPurchased(tItemId));
  });
}

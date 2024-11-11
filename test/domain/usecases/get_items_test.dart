import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';
import 'package:shop_ez/domain/usecases/get_items.dart';

/// Tests for the `GetItems` use case.
class MockShoppingListRepository extends Mock
    implements ShoppingListRepository {}

void main() {
  late GetItems usecase;
  late MockShoppingListRepository mockRepository;

  /// Initial setup for the tests.
  setUp(() {
    mockRepository = MockShoppingListRepository();
    usecase = GetItems(mockRepository);
  });

  /// Test items.
  const tItems = [
    Item(id: '1', name: 'Item 1', category: 'Category 1'),
    Item(id: '2', name: 'Item 2', category: 'Category 2'),
  ];

  /// Tests if the items are retrieved from the repository successfully.
  test('should get items from the repository', () async {
    // arrange
    when(() => mockRepository.getItems())
        .thenAnswer((_) async => const Right(tItems));
    // act
    final result = await usecase();
    // assert
    expect(result, const Right(tItems));
    verify(() => mockRepository.getItems()).called(1);
  });

  /// Tests if the use case returns a failure when retrieving items fails.
  test('should return failure when getting items fails', () async {
    // arrange
    when(() => mockRepository.getItems()).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed to get items')));
    // act
    final result = await usecase();
    // assert
    expect(result, const Left(DatabaseFailure('Failed to get items')));
    verify(() => mockRepository.getItems()).called(1);
  });
}

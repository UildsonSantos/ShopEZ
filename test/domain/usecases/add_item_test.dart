import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';
import 'package:shop_ez/domain/usecases/add_item.dart';

class MockShoppingListRepository extends Mock
    implements ShoppingListRepository {}

void main() {
  late AddItem usecase;
  late MockShoppingListRepository mockRepository;

  setUp(() {
    mockRepository = MockShoppingListRepository();
    usecase = AddItem(mockRepository);
  });

  const tItem = Item(id: '1', name: 'Test Item', category: 'Test Category');

  test('should add item to the repository', () async {
    // arrange
    when(() => mockRepository.addItem(tItem))
        .thenAnswer((_) async => const Right(tItem));
    // act
    final result = await usecase(tItem);
    // assert
    expect(result, const Right(tItem));
    verify(() => mockRepository.addItem(tItem)).called(1);
  });

  test('should return failure when adding item fails', () async {
    // arrange
    when(() => mockRepository.addItem(tItem)).thenAnswer(
        (_) async => const Left(DatabaseFailure('Failed to add item')));
    // act
    final result = await usecase(tItem);
    // assert
    expect(result, const Left(DatabaseFailure('Failed to add item')));
    verify(() => mockRepository.addItem(tItem)).called(1);
  });
}

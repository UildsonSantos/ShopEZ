import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/usecases/add_item.dart';
import 'package:shop_ez/domain/usecases/get_items.dart';
import 'package:shop_ez/domain/usecases/mark_item_as_purchased.dart';
import 'package:shop_ez/domain/usecases/remove_item.dart';
import 'package:shop_ez/presentation/blocs/blocs.dart';

/// Tests for the `ShoppingListBloc`.
class MockAddItem extends Mock implements AddItem {}

class MockRemoveItem extends Mock implements RemoveItem {}

class MockMarkItemAsPurchased extends Mock implements MarkItemAsPurchased {}

class MockGetItems extends Mock implements GetItems {}

void main() {
  late ShoppingListBloc bloc;
  late MockAddItem mockAddItem;
  late MockRemoveItem mockRemoveItem;
  late MockMarkItemAsPurchased mockMarkItemAsPurchased;
  late MockGetItems mockGetItems;

  /// Initial setup for the tests.
  setUp(() {
    mockAddItem = MockAddItem();
    mockRemoveItem = MockRemoveItem();
    mockMarkItemAsPurchased = MockMarkItemAsPurchased();
    mockGetItems = MockGetItems();
    bloc = ShoppingListBloc(
      addItem: mockAddItem,
      removeItem: mockRemoveItem,
      markItemAsPurchased: mockMarkItemAsPurchased,
      getItems: mockGetItems,
    );
  });

  /// Test item.
  const tItem = Item(id: '1', name: 'Test Item', category: 'Test Category');

  /// Test items.
  const tItems = [
    Item(id: '1', name: 'Item 1', category: 'Category 1'),
    Item(id: '2', name: 'Item 2', category: 'Category 2'),
  ];

  /// Group of tests for the `ShoppingListBloc`.
  group('ShoppingListBloc', () {
    /// Tests if the bloc emits the correct states when a `GetItemsEvent` is added.
    blocTest<ShoppingListBloc, ShoppingListState>(
      'emits [ShoppingListLoading, ShoppingListLoaded] when GetItemsEvent is added',
      build: () {
        when(() => mockGetItems()).thenAnswer((_) async => const Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(GetItemsEvent()),
      expect: () => [
        ShoppingListLoading(),
        const ShoppingListLoaded(tItems),
      ],
    );

    /// Tests if the bloc emits the correct states when an `AddItemEvent` is added.
    blocTest<ShoppingListBloc, ShoppingListState>(
      'emits [ShoppingListLoading, ShoppingListLoaded] when AddItemEvent is added',
      build: () {
        when(() => mockAddItem(tItem))
            .thenAnswer((_) async => const Right(tItem));
        when(() => mockGetItems()).thenAnswer((_) async => const Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(const AddItemEvent(tItem)),
      expect: () => [
        ShoppingListLoading(),
        const ShoppingListLoaded(tItems),
      ],
    );

    /// Tests if the bloc emits the correct states when a `RemoveItemEvent` is added.
    blocTest<ShoppingListBloc, ShoppingListState>(
      'emits [ShoppingListLoading, ShoppingListLoaded] when RemoveItemEvent is added',
      build: () {
        when(() => mockRemoveItem('1'))
            .thenAnswer((_) async => const Right(null));
        when(() => mockGetItems()).thenAnswer((_) async => const Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(const RemoveItemEvent('1')),
      expect: () => [
        ShoppingListLoading(),
        const ShoppingListLoaded(tItems),
      ],
    );

    /// Tests if the bloc emits the correct states when a `MarkItemAsPurchasedEvent` is added.
    blocTest<ShoppingListBloc, ShoppingListState>(
      'emits [ShoppingListLoading, ShoppingListLoaded] when MarkItemAsPurchasedEvent is added',
      build: () {
        when(() => mockMarkItemAsPurchased('1'))
            .thenAnswer((_) async => const Right(null));
        when(() => mockGetItems()).thenAnswer((_) async => const Right(tItems));
        return bloc;
      },
      act: (bloc) => bloc.add(const MarkItemAsPurchasedEvent('1')),
      expect: () => [
        ShoppingListLoading(),
        const ShoppingListLoaded(tItems),
      ],
    );
  });
}

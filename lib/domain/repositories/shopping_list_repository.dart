import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';

/// Repository interface for managing shopping list items.
abstract class ShoppingListRepository {
  /// Adds an item to the shopping list.
  ///
  /// Returns a [Right] with the added item if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Item>> addItem(Item item);

  /// Removes an item from the shopping list.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> removeItem(String itemId);

  /// Marks an item as purchased.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> markItemAsPurchased(String itemId);

  /// Retrieves all items from the shopping list.
  ///
  /// Returns a [Right] with the list of items if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, List<Item>>> getItems();
}

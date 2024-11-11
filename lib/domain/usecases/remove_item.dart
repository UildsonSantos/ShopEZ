import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

/// Use case for removing an item from the shopping list.
class RemoveItem {
  /// Repository responsible for managing shopping list items.
  final ShoppingListRepository repository;

  /// Creates a [RemoveItem] instance.
  RemoveItem(this.repository);

  /// Removes an item from the shopping list.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> call(String itemId) async {
    return await repository.removeItem(itemId);
  }
}

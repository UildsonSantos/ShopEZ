import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

/// Use case for marking an item as purchased.
class MarkItemAsPurchased {
  /// Repository responsible for managing shopping list items.
  final ShoppingListRepository repository;

  /// Creates a [MarkItemAsPurchased] instance.
  MarkItemAsPurchased(this.repository);

  /// Marks an item as purchased.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> call(String itemId) async {
    return await repository.markItemAsPurchased(itemId);
  }
}

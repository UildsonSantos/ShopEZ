import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

/// Use case for retrieving all items from the shopping list.
class GetItems {
  /// Repository responsible for managing shopping list items.
  final ShoppingListRepository repository;

  /// Creates a [GetItems] instance.
  GetItems(this.repository);

  /// Retrieves all items from the shopping list.
  ///
  /// Returns a [Right] with the list of items if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, List<Item>>> call() async {
    return await repository.getItems();
  }
}

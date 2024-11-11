import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

/// Use case for adding an item to the shopping list.
class AddItem {
  /// Repository responsible for managing shopping list items.
  final ShoppingListRepository repository;

  /// Creates an [AddItem] instance.
  AddItem(this.repository);

  /// Adds an item to the shopping list.
  ///
  /// Returns a [Right] with the added item if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Item>> call(Item item) async {
    return await repository.addItem(item);
  }
}

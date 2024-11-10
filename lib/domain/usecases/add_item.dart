import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

class AddItem {
  final ShoppingListRepository repository;

  AddItem(this.repository);

  Future<Either<Failure, Item>> call(Item item) async {
    return await repository.addItem(item);
  }
}

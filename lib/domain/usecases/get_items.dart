import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

class GetItems {
  final ShoppingListRepository repository;

  GetItems(this.repository);

  Future<Either<Failure, List<Item>>> call() async {
    return await repository.getItems();
  }
}

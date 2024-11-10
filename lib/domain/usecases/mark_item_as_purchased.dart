import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

class MarkItemAsPurchased {
  final ShoppingListRepository repository;

  MarkItemAsPurchased(this.repository);

  Future<Either<Failure, void>> call(String itemId) async {
    return await repository.markItemAsPurchased(itemId);
  }
}

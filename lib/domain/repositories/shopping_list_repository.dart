import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';

abstract class ShoppingListRepository {
  Future<Either<Failure, Item>> addItem(Item item);
  Future<Either<Failure, void>> removeItem(String itemId);
  Future<Either<Failure, void>> markItemAsPurchased(String itemId);
  Future<Either<Failure, List<Item>>> getItems();
}

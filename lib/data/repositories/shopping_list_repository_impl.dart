import 'package:dartz/dartz.dart';
import 'package:shop_ez/data/datasources/local_data_source.dart';
import 'package:shop_ez/data/models/item_model.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/shopping_list_repository.dart';

class ShoppingListRepositoryImpl implements ShoppingListRepository {
  final LocalDataSource localDataSource;

  ShoppingListRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Item>> addItem(Item item) async {
    return await localDataSource
        .addItem(ItemModel.fromEntity(item))
        .then((either) => either.map((model) => model as Item));
  }

  @override
  Future<Either<Failure, void>> removeItem(String itemId) async {
    return await localDataSource.removeItem(itemId);
  }

  @override
  Future<Either<Failure, void>> markItemAsPurchased(String itemId) async {
    return await localDataSource.markItemAsPurchased(itemId);
  }

  @override
  Future<Either<Failure, List<Item>>> getItems() async {
    return await localDataSource.getItems().then((either) =>
        either.map((list) => list.map((model) => model as Item).toList()));
  }
}

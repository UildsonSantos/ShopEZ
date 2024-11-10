import 'package:dartz/dartz.dart';
import 'package:shop_ez/data/datasources/database_helper.dart';
import 'package:shop_ez/data/models/item_model.dart';
import 'package:shop_ez/data/models/category_model.dart';
import 'package:shop_ez/data/models/status_model.dart';
import 'package:shop_ez/domain/errors/failure.dart';

class LocalDataSource {
  final DatabaseHelper _databaseHelper;

  LocalDataSource(this._databaseHelper);

  Future<Either<Failure, ItemModel>> addItem(ItemModel item) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert('items', item.toMap());
      return Right(item);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add item, $e'));
    }
  }

  Future<Either<Failure, void>> removeItem(String itemId) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete('items', where: 'id = ?', whereArgs: [itemId]);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to remove item, $e'));
    }
  }

  Future<Either<Failure, void>> markItemAsPurchased(String itemId) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        'items',
        {'isPurchased': 1},
        where: 'id = ?',
        whereArgs: [itemId],
      );
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to mark item as purchased, $e'));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getItems() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('items');
      return Right(maps.map((map) => ItemModel.fromMap(map)).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get items, $e'));
    }
  }

  Future<Either<Failure, CategoryModel>> addCategory(
      CategoryModel category) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert('categories', category.toMap());
      return Right(category);
    } catch (e) {
      return Left(DatabaseFailure('Failed to add category, $e'));
    }
  }

  Future<Either<Failure, void>> removeCategory(String categoryId) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete('categories', where: 'id = ?', whereArgs: [categoryId]);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to remove category, $e'));
    }
  }

  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query('categories');
      return Right(maps.map((map) => CategoryModel.fromMap(map)).toList());
    } catch (e) {
      return Left(DatabaseFailure('Failed to get categories, $e'));
    }
  }

  Future<Either<Failure, StatusModel>> updateStatus(StatusModel status) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        'status',
        status.toMap(),
        where: 'id = ?',
        whereArgs: [status.id],
      );
      return Right(status);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update status, $e'));
    }
  }

  Future<Either<Failure, StatusModel>> getStatus(String itemId) async {
    try {
      final db = await _databaseHelper.database;
      final List<Map<String, dynamic>> maps = await db.query(
        'status',
        where: 'id = ?',
        whereArgs: [itemId],
      );
      if (maps.isNotEmpty) {
        return Right(StatusModel.fromMap(maps.first));
      } else {
        return const Left(DatabaseFailure('Status not found'));
      }
    } catch (e) {
      return Left(DatabaseFailure('Failed to get status, $e'));
    }
  }
}

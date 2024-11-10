import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/errors/failure.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> addCategory(Category category);
  Future<Either<Failure, void>> removeCategory(String categoryId);
  Future<Either<Failure, List<Category>>> getCategories();
}

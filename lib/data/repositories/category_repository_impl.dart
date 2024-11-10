import 'package:dartz/dartz.dart';
import 'package:shop_ez/data/datasources/local_data_source.dart';
import 'package:shop_ez/data/models/category_model.dart';
import 'package:shop_ez/domain/entities/category.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final LocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, Category>> addCategory(Category category) async {
    return await localDataSource
        .addCategory(CategoryModel.fromEntity(category))
        .then((either) => either.map((model) => model as Category));
  }

  @override
  Future<Either<Failure, void>> removeCategory(String categoryId) async {
    return await localDataSource.removeCategory(categoryId);
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    return await localDataSource.getCategories().then((either) =>
        either.map((list) => list.map((model) => model as Category).toList()));
  }
}

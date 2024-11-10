import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/category.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

class AddCategory {
  final CategoryRepository repository;

  AddCategory(this.repository);

  Future<Either<Failure, Category>> call(Category category) async {
    return await repository.addCategory(category);
  }
}

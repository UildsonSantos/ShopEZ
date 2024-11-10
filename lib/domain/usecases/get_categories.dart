import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/category.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

class GetCategories {
  final CategoryRepository repository;

  GetCategories(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}

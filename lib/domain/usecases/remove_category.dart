import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

class RemoveCategory {
  final CategoryRepository repository;

  RemoveCategory(this.repository);

  Future<Either<Failure, void>> call(String categoryId) async {
    return await repository.removeCategory(categoryId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/category.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

/// Use case for retrieving all categories from the system.
class GetCategories {
  /// Repository responsible for managing categories.
  final CategoryRepository repository;

  /// Creates a [GetCategories] instance.
  GetCategories(this.repository);

  /// Retrieves all categories from the system.
  ///
  /// Returns a [Right] with the list of categories if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, List<Category>>> call() async {
    return await repository.getCategories();
  }
}

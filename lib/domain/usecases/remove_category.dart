import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

/// Use case for removing a category from the system.
class RemoveCategory {
  /// Repository responsible for managing categories.
  final CategoryRepository repository;

  /// Creates a [RemoveCategory] instance.
  RemoveCategory(this.repository);

  /// Removes a category from the system.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> call(String categoryId) async {
    return await repository.removeCategory(categoryId);
  }
}

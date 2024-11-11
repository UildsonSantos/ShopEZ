import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/entities.dart';
import 'package:shop_ez/domain/errors/failure.dart';

/// Repository interface for managing categories.
abstract class CategoryRepository {
  /// Adds a category to the system.
  ///
  /// Returns a [Right] with the added category if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Category>> addCategory(Category category);

  /// Removes a category from the system.
  ///
  /// Returns a [Right] with `void` if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, void>> removeCategory(String categoryId);

  /// Retrieves all categories from the system.
  ///
  /// Returns a [Right] with the list of categories if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, List<Category>>> getCategories();
}

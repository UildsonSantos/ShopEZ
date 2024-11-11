import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/category.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/category_repository.dart';

/// Use case for adding a category to the system.
class AddCategory {
  /// Repository responsible for managing categories.
  final CategoryRepository repository;

  /// Creates an [AddCategory] instance.
  AddCategory(this.repository);

  /// Adds a category to the system.
  ///
  /// Returns a [Right] with the added category if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Category>> call(Category category) async {
    return await repository.addCategory(category);
  }
}

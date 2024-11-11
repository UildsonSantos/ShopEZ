import 'package:dartz/dartz.dart';
import 'package:shop_ez/domain/entities/status.dart';
import 'package:shop_ez/domain/errors/failure.dart';
import 'package:shop_ez/domain/repositories/status_repository.dart';

/// Use case for updating the status of an item.
class UpdateStatus {
  /// Repository responsible for managing item statuses.
  final StatusRepository repository;

  /// Creates an [UpdateStatus] instance.
  UpdateStatus(this.repository);

  /// Updates the status of an item.
  ///
  /// Returns a [Right] with the updated status if successful, or a [Left] with a [Failure] if an error occurs.
  Future<Either<Failure, Status>> call(Status status) async {
    return await repository.updateStatus(status);
  }
}

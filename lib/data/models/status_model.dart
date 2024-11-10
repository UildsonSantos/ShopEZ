import 'package:shop_ez/domain/entities/status.dart';

class StatusModel extends Status {
  const StatusModel({
    required super.id,
    required super.status,
  });

  factory StatusModel.fromEntity(Status status) {
    return StatusModel(
      id: status.id,
      status: status.status,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.index,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      id: map['id'],
      status: PurchaseStatus.values[map['status']],
    );
  }
}

import 'package:equatable/equatable.dart';

enum PurchaseStatus {
  notPurchased,
  purchased,
}

class Status extends Equatable {
  final String id;
  final PurchaseStatus status;

  const Status({
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id, status];

  Status copyWith({
    String? id,
    PurchaseStatus? status,
  }) {
    return Status(
      id: id ?? this.id,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status.index,
    };
  }

  factory Status.fromMap(Map<String, dynamic> map) {
    return Status(
      id: map['id'],
      status: PurchaseStatus.values[map['status']],
    );
  }
}
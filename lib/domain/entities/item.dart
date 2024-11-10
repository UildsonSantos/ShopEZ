import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String category;
  final bool isPurchased;

  const Item({
    required this.id,
    required this.name,
    required this.category,
    this.isPurchased = false,
  });

  @override
  List<Object?> get props => [id, name, category, isPurchased];

  Item copyWith({
    String? id,
    String? name,
    String? category,
    bool? isPurchased,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isPurchased': isPurchased,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      isPurchased: map['isPurchased'],
    );
  }
}

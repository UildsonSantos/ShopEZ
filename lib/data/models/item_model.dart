import 'package:shop_ez/domain/entities/item.dart';

class ItemModel extends Item {
  const ItemModel({
    required super.id,
    required super.name,
    required super.category,
    super.isPurchased,
  });

  factory ItemModel.fromEntity(Item item) {
    return ItemModel(
      id: item.id,
      name: item.name,
      category: item.category,
      isPurchased: item.isPurchased,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'isPurchased': isPurchased ? 1 : 0,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      isPurchased: map['isPurchased'] == 1,
    );
  }
}

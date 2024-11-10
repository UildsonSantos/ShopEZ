part of 'shopping_list_bloc.dart';

sealed class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();

  @override
  List<Object> get props => [];
}

final class AddItemEvent extends ShoppingListEvent {
  final Item item;

  const AddItemEvent(this.item);

  @override
  List<Object> get props => [item];
}

final class RemoveItemEvent extends ShoppingListEvent {
  final String itemId;

  const RemoveItemEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

final class MarkItemAsPurchasedEvent extends ShoppingListEvent {
  final String itemId;

  const MarkItemAsPurchasedEvent(this.itemId);

  @override
  List<Object> get props => [itemId];
}

final class GetItemsEvent extends ShoppingListEvent {}

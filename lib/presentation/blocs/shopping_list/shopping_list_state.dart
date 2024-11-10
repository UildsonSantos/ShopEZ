part of 'shopping_list_bloc.dart';

sealed class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

final class ShoppingListInitial extends ShoppingListState {}

final class ShoppingListLoading extends ShoppingListState {}

final class ShoppingListLoaded extends ShoppingListState {
  final List<Item> items;
  final Color? themeColor;
  final String? alert;

  const ShoppingListLoaded(this.items, {this.themeColor, this.alert});

  @override
  List<Object> get props => [items, themeColor ?? '', alert ?? ''];
}

final class ShoppingListError extends ShoppingListState {
  final String message;

  const ShoppingListError(this.message);

  @override
  List<Object> get props => [message];
}

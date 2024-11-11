import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/presentation/blocs/blocs.dart';

/// Main screen for the shopping list application.
class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEZ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              _showColorPicker(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              _showAlertDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort_by_alpha),
            onPressed: () {
              BlocProvider.of<ShoppingListBloc>(context)
                  .add(SortItemsAlphabeticallyEvent());
            },
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              BlocProvider.of<ShoppingListBloc>(context)
                  .add(SortItemsByStatusEvent());
            },
          ),
        ],
      ),
      body: BlocBuilder<ShoppingListBloc, ShoppingListState>(
        builder: (context, state) {
          if (state is ShoppingListInitial) {
            BlocProvider.of<ShoppingListBloc>(context).add(GetItemsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShoppingListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShoppingListLoaded) {
            final items = state.items;
            final themeColor = state.themeColor ?? Colors.blue;
            final alert = state.alert;

            return Column(
              children: [
                if (alert != null && alert.isNotEmpty)
                  Container(
                    color: themeColor,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      alert,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.category),
                        trailing: Checkbox(
                          value: item.isPurchased,
                          onChanged: (value) {
                            _markItemAsPurchased(context, item.id);
                          },
                        ),
                        onLongPress: () {
                          _removeItem(context, item.id);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ShoppingListError) {
            return Center(child: Text('Erro: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown error'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  /// Shows a dialog to add a new item to the shopping list.
  void _showAddItemDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final item = Item(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  category: categoryController.text,
                );
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(AddItemEvent(item));
                Navigator.of(dialogContext).pop();
              },
              child: const Text('To add'),
            ),
          ],
        );
      },
    );
  }

  /// Removes an item from the shopping list.
  void _removeItem(BuildContext context, String itemId) {
    BlocProvider.of<ShoppingListBloc>(context).add(RemoveItemEvent(itemId));
  }

  /// Marks an item as purchased.
  void _markItemAsPurchased(BuildContext context, String itemId) {
    BlocProvider.of<ShoppingListBloc>(context)
        .add(MarkItemAsPurchasedEvent(itemId));
  }

  /// Shows a color picker dialog to choose the theme color.
  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Choose Theme Color'),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: Colors.blue,
              onColorChanged: (color) {
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(SetThemeColorEvent(color));
                Navigator.of(dialogContext).pop();
              },
            ),
          ),
        );
      },
    );
  }

  /// Shows a dialog to set an alert message.
  void _showAlertDialog(BuildContext context) {
    final TextEditingController alertController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Set Alert'),
          content: TextField(
            controller: alertController,
            decoration: const InputDecoration(labelText: 'Alert'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(SetAlertEvent(alertController.text));
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Define'),
            ),
          ],
        );
      },
    );
  }
}

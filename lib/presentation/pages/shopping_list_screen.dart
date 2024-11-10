import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shop_ez/domain/entities/item.dart';
import 'package:shop_ez/presentation/blocs/blocs.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
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
            return const Center(child: Text('Erro desconhecido'));
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

  void _showAddItemDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Adicionar Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Categoria'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
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
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _removeItem(BuildContext context, String itemId) {
    BlocProvider.of<ShoppingListBloc>(context).add(RemoveItemEvent(itemId));
  }

  void _markItemAsPurchased(BuildContext context, String itemId) {
    BlocProvider.of<ShoppingListBloc>(context)
        .add(MarkItemAsPurchasedEvent(itemId));
  }

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Escolher Cor do Tema'),
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

  void _showAlertDialog(BuildContext context) {
    final TextEditingController alertController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Definir Alerta'),
          content: TextField(
            controller: alertController,
            decoration: const InputDecoration(labelText: 'Alerta'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<ShoppingListBloc>(context)
                    .add(SetAlertEvent(alertController.text));
                Navigator.of(dialogContext).pop();
              },
              child: const Text('Definir'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:carts1/cart_Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// Home Page

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  LocalCartBloc carBloc = LocalCartBloc();

  @override
  void initState() {
    super.initState();
    carBloc = BlocProvider.of<LocalCartBloc>(context, listen: false);
    carBloc.add(FetchLocalCartEvent());
  }

  // final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _quantityController = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  // void _showForm(BuildContext ctx, int? itemKey) async {

  //   showModalBottomSheet(
  //       context: ctx,
  //       elevation: 5,
  //       isScrollControlled: true,
  //       builder: (_) => Container(
  //             padding: EdgeInsets.only(
  //                 bottom: MediaQuery.of(ctx).viewInsets.bottom,
  //                 top: 15,
  //                 left: 15,
  //                 right: 15),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               children: [
  //                 TextField(
  //                   controller: _nameController,
  //                   decoration: const InputDecoration(hintText: 'Name'),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 TextField(
  //                   controller: _quantityController,
  //                   keyboardType: TextInputType.number,
  //                   decoration: const InputDecoration(hintText: 'Quantity'),
  //                 ),
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 ElevatedButton(
  //                   onPressed: () async {
  //                     print(itemKey);
  //                     // Save new item
  //                     if (itemKey == null) {
  //                       // shoping.createItem({
  //                       //   "name": _nameController.text,
  //                       //   "quantity": _quantityController.text
  //                       // });
  //                       BlocProvider.of<LocalCartBloc>(context, listen: false)
  //                         ..add(LocalCartItemAddEvent(prodData: {
  //                           "name": _nameController.text,
  //                           "quantity": _quantityController.text
  //                         }));
  //                     }

  //                     // update an existing item
  //                     if (itemKey != null) {
  //                       // shoping.updateItem(itemKey, {
  //                       //   // 'name': _nameController.text.trim(),
  //                       //   'quantity': _quantityController.text.trim()
  //                       // });

  //                       BlocProvider.of<LocalCartBloc>(context, listen: false)
  //                         ..add(LocalCartItemPutEvent(id: itemKey, prodData: {
  //                           "name": _nameController.text,
  //                           "quantity": _quantityController.text
  //                         }));
  //                     }

  //                     // Clear the text fields
  //                     _nameController.text = '';
  //                     _quantityController.text = '';

  //                     Navigator.of(context).pop(); // Close the bottom sheet
  //                   },
  //                   child: Text(itemKey == null ? 'Create New' : 'Update'),
  //                 ),
  //                 const SizedBox(
  //                   height: 15,
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Screen'),
      ),
      body: BlocConsumer<LocalCartBloc, LocalCartState>(
          listener: (context, state) {
        
      }, builder: (context, state) {
        print(state);
        if (state is LocalCartSuccessState) {
          return state.data.length > 0
              ? Container(
                  child: ListView.builder(
                      // the list of items
                      // itemCount: _items.length,
                      itemCount: state.data.length,
                      itemBuilder: (_, index) {
                        // final currentItem = _items[index];
                        final currentItem = state.data[index];
                        return Card(
                          color: Colors.orange.shade100,
                          margin: const EdgeInsets.all(10),
                          elevation: 3,
                          child: ListTile(
                              title: Text(currentItem['name']),
                              subtitle:
                                  Text(currentItem['quantity'].toString()),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Edit button
                                  Row(
                                    children: [
                                      IconButton(
                                          icon: const Icon(Icons.remove),
                                          onPressed: () {
                                            // print(currentItem['key']);
                                            // _showForm(context, currentItem['key']);

                                            BlocProvider.of<LocalCartBloc>(
                                                context,
                                                listen: false)
                                              ..add(LocalCartItemPutEvent(
                                                  id: currentItem['key'],
                                                  prodData: {
                                                    "id": currentItem["id"],
                                                    "name": currentItem['name'],
                                                    "quantity": currentItem[
                                                            'quantity'] -
                                                        1
                                                  }));
                                          }),
                                      Text(' ${currentItem['quantity']}'),
                                      IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            // print(currentItem['key']);
                                            // _showForm(context, currentItem['key']);
                                            BlocProvider.of<LocalCartBloc>(
                                                context,
                                                listen: false)
                                              ..add(LocalCartItemPutEvent(
                                                  id: currentItem['key'],
                                                  prodData: {
                                                    "id":currentItem["id"],
                                                    "name": currentItem['name'],
                                                    "quantity": currentItem[
                                                            'quantity'] +
                                                        1
                                                  }));
                                          }),
                                    ],
                                  ),
                                  // Delete button
                                  IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        // shoping.deleteItem(currentItem['key']),
                                        BlocProvider.of<LocalCartBloc>(context,
                                            listen: false)
                                          ..add(LocalCartItemDelEvent(
                                              id: currentItem['key']));
                                      })
                                ],
                              )),
                        );
                      }),
                )
              : const Center(
                  child: Text(
                    'No Data',
                    style: TextStyle(fontSize: 30),
                  ),
                );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

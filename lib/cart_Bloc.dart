import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'hive_perper.dart';

class LocalCartBloc extends Bloc<LocalCartEvent, LocalCartState> {
  ShopC shoping = ShopC();

  LocalCartBloc() : super(LocalCartInitialState()) {
    on<FetchLocalCartEvent>(_LocalCartMethod);

    // ====================ADD==========================
    on<LocalCartItemAddEvent>(_LocalCartAddMethod);

    // ! Update LocalCart and Wishlist
    on<LocalCartItemPutEvent>(_LocalCartUpdateMethod);

    // ! Delete LocalCart and Wishlist
    on<LocalCartItemDelEvent>(_LocalCartDeleteMethod);
  }

  //  ! LocalCart Data Get

  void _LocalCartMethod(FetchLocalCartEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      // dynamic user = await shoping.readItem(key);

      // dynamic user = shoping.shoppingBox.keys.map((key) {
      //   final value = shoping.shoppingBox.get(key);
      //   return {
      //     "key": key,
      //     "name": value["name"],
      //     "quantity": value['quantity']
      //   };
      // }).toList();
      dynamic user = shoping.refreshItems();

      if (user != null) {
        emit(LocalCartSuccessState(data: user));
      }
      // emit(LocalCartInitialState());
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  //  ============ LocalCart AND WISHLIST PRODUCT ADD ======================
  _LocalCartAddMethod(LocalCartItemAddEvent event, Emitter emit) async {
    print(event);
    emit(LocalCartLoadingState());
    try {
      shoping.createItem(event.prodData);
      dynamic user = shoping.refreshItems();
      if (user != null) {
        emit(LocalCartSuccessState(data: user));
      } else {
        // snackBar(event.context, user['msg'] ?? '');
        emit(LocalCartInitialState());
      }
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  // !  ==============  END ADD METHOD ===============================

  // ! Update LocalCart and WishlIst Item
  void _LocalCartUpdateMethod(LocalCartItemPutEvent event, Emitter emit) async {
    print(event);
    emit(LocalCartLoadingState());
    try {
      shoping.updateItem(event.id, event.prodData);
      dynamic user = shoping.refreshItems();

      if (user != null) {
        emit(LocalCartSuccessState(data: user));
      }
      // emit(LocalCartWishInitialState());
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }

  // ! Delete for LocalCart AND WISHLIST
  void _LocalCartDeleteMethod(LocalCartItemDelEvent event, Emitter emit) async {
    // print(event);
    emit(LocalCartLoadingState());
    try {
      shoping.deleteItem(event.id);
      dynamic user = shoping.refreshItems();

      if (user != null) {
        // snackBar(event.context, user['msg']);
        emit(LocalCartSuccessState(data: user));
      } else {
        emit(LocalCartInitialState());
      }
    } catch (e) {
      emit(LocalCartFailedState());
    }
  }
}

// ! Event for LocalCart and WishList
abstract class LocalCartEvent extends Equatable {
  LocalCartEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchLocalCartEvent extends LocalCartEvent {
  FetchLocalCartEvent();
  @override
  List<Object> get props => [];
}

// 1 LocalCart Item Add and Wishlist add
class LocalCartItemAddEvent extends LocalCartEvent {
  final Map<String, dynamic> prodData;
  final dynamic context;

  LocalCartItemAddEvent({required this.prodData, this.context});
  @override
  List<Object> get props => [];
}

//  LocalCart Item Event
class LocalCartItemPutEvent extends LocalCartEvent {
  final dynamic id;
  final int? quantity;
  final Map<String, dynamic> prodData;
  final dynamic context;
  LocalCartItemPutEvent(
      {required this.id, required this.prodData, this.quantity, this.context});
  @override
  List<Object> get props => [];
}

class LocalCartItemDelEvent extends LocalCartEvent {
  final int id;
  final dynamic context;
  LocalCartItemDelEvent({required this.id, this.context});
  @override
  List<Object> get props => [];
}

// / ! State in LocalCart
abstract class LocalCartState extends Equatable {
  const LocalCartState();

  @override
  List<Object> get props => [];
}

class LocalCartInitialState extends LocalCartState {}

class LocalCartLoadingState extends LocalCartState {}

class LocalCartSuccessState extends LocalCartState {
  final dynamic data;
  LocalCartSuccessState({this.data});
}

class LocalCartFailedState extends LocalCartState {
  final String? message;
  LocalCartFailedState({this.message});
}

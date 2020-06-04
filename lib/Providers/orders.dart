import 'package:flutter/foundation.dart';
import 'package:myshop_app/Providers/cart.dart';
//import '../Widgets/cartItem.dart';
import './cart.dart';

class OrderItem{
  final String id;
  final double amount;
  final List<CartModel> cartProducts;
  final DateTime dateTime;

  OrderItem({
  @required this.id,
  @required this.amount,
  @required this.cartProducts,
  @required this.dateTime
  });
}

class Orders with ChangeNotifier{
  List<OrderItem> _orders =[];

  List<OrderItem> get orders{
    return [..._orders];
  }

  void addOrder (List<CartModel> cartItems, double total){
    _orders.insert(0, OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      cartProducts: cartItems,
      dateTime: DateTime.now()
    ));
   notifyListeners();
  }


}
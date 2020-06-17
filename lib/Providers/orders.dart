import 'package:flutter/foundation.dart';
import 'package:myshop_app/Providers/cart.dart';
//import '../Widgets/cartItem.dart';
import './cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
Future<void> fetchandsetOrders() async{
  final url = 'https://myshop-app-flutter.firebaseio.com/orders.json';
  final response = await http.get(url);
  final  List<OrderItem> loadedOrders = [];
  final extractedData = json.decode(response.body) as Map<String, dynamic>;
 if(extractedData == null){
          return;
 }
 extractedData.forEach((orderId,orderData){
       loadedOrders.add(OrderItem(
         id: orderId,
         amount: orderData['amount'],
        dateTime: DateTime.parse(orderData['datetime']),
        cartProducts: (orderData['products'] as List<dynamic>).map((item) => CartModel(
          id: item['id'],
           title: item['title'],
            price: item['price'],
             quantity: item['quantity']
             ),
              
        ).toList()
         ));
 });
    _orders =loadedOrders.reversed.toList();
   notifyListeners();
}
  Future<void> addOrder (List<CartModel> cartItems, double total) async{
    final url = 'https://myshop-app-flutter.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(url,
            body: json.encode({
              'amount': total,
              'datetime': timestamp.toIso8601String(),
              'products': cartItems.map((cp) => {
                     'id' : cp.id,
                     'title':cp.title,
                     'price':cp.price,
                     'quantity':cp.quantity
              }).toList(),                     //cp -> cartproduct
            })
    );
    _orders.insert(0, OrderItem(
      id: json.decode(response.body)['name'],
      amount: total,
      cartProducts: cartItems,
      dateTime: timestamp
    ));
   notifyListeners();
  }


}
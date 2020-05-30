import 'package:flutter/material.dart';
import '../Providers/orders.dart';
class OrderProduct extends StatelessWidget {
  final OrderItem order;
  OrderProduct(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: Column(children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime),
            ),
             trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: (){}),
          ),
        ],),
    );
  }
}
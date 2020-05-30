import 'package:flutter/material.dart';
import '../Providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../Widgets/readyToOrder.dart';
import '../Widgets/drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orderData =  Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: MainDrawer(),
      body: ListView.builder(
        itemCount: orderData.orders.length,
        itemBuilder: (ctx,i) =>OrderProduct(orderData.orders[i])),
    );
  }
}
import 'package:flutter/material.dart';
import '../Pages/ordersScreen.dart';
class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Welcome Customer'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop,),
            title: Text('Shop'),
            onTap:() {
              Navigator.of(context).pushNamed('/');
              },
          ),
            ListTile(
            leading: Icon(Icons.payment,),
            title: Text('Order'),
            onTap:() {
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
          ),
        ],
      ),
    );
  }
}